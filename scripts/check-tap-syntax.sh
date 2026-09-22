#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Run the same tap-syntax checks as CI against the working tree:
brew style, brew readall, and brew audit (the brew test-bot
--only-tap-syntax set).

brew readall and brew audit only accept installed tap names, so the working
tree is exposed to Homebrew as a throwaway tap symlink under
$(brew --repository)/Library/Taps and removed afterwards. The installed
pszypowicz/tap clone is never touched, and uncommitted changes are what
gets checked.

Homebrew loads a non-official tap only when its trust file lists it, so the
throwaway tap is trusted inside a temporary copy of the Homebrew user config
directory. The real trust.json is never written.

Usage: scripts/check-tap-syntax.sh [--repo <dir>]

Flags:
  --repo <dir>  Tap repository to check (default: the repo containing this script)
  -h, --help    Show this help.

Example:
  scripts/check-tap-syntax.sh
EOF
}

repo=""
while [[ $# -gt 0 ]]
do
  case "$1" in
    --repo)
      repo="$2"
      shift 2
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "${repo}" ]]
then
  repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi
if [[ ! -d "${repo}" ]]
then
  echo "Not a directory: ${repo}" >&2
  exit 1
fi
repo="$(cd "${repo}" && pwd)"

taps_dir="$(brew --repository)/Library/Taps"
link_dir="${taps_dir}/tap-syntax-check"
link="${link_dir}/homebrew-worktree"
tap="tap-syntax-check/worktree"

scratch="$(mktemp -d)"
check_log="${scratch}/check.log"

# shellcheck disable=SC2329  # invoked via the EXIT trap
cleanup() {
  rm -f "${link}"
  rmdir "${link_dir}" 2>/dev/null || true
  rm -rf "${scratch}"
}
trap cleanup EXIT

mkdir -p "${link_dir}"
ln -sfn "${repo}" "${link}"

# Deprecated-but-still-loading API calls must fail here exactly as they do
# in CI, and a hook should not trigger a slow brew auto-update.
export HOMEBREW_DEVELOPER=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

# Homebrew loads formulae and casks from a non-official tap only when its
# trust file names the tap. An untrusted tap makes readall and audit print a
# skip warning and exit 0, so the run passes having read nothing, and the
# throwaway tap above is a fresh name that no trust file carries.
#
# Trusting it for real would write the user's trust.json and leave a stale
# entry behind whenever the cleanup does not run. So the whole Homebrew user
# config directory is copied into a temporary config home and the throwaway
# tap is trusted only in the copy. brew.env and the existing trust entries
# still apply, and the copy goes with the scratch directory.
#
# XDG_CONFIG_HOME is what selects that directory: brew reads
# $XDG_CONFIG_HOME/homebrew, then $HOMEBREW_XDG_CONFIG_HOME/homebrew, then
# ~/.homebrew. Setting HOMEBREW_USER_CONFIG_HOME from here does nothing,
# because brew clears it before computing its own value.
if [[ -n "${XDG_CONFIG_HOME-}" ]]
then
  real_config_home="${XDG_CONFIG_HOME}/homebrew"
elif [[ -n "${HOMEBREW_XDG_CONFIG_HOME-}" ]]
then
  real_config_home="${HOMEBREW_XDG_CONFIG_HOME}/homebrew"
else
  real_config_home="${HOME}/.homebrew"
fi

config_home="${scratch}/config"
mkdir -p "${config_home}/homebrew"
chmod 700 "${config_home}/homebrew"
# -L resolves symlinks, because brew.env is often a relative link into a
# dotfiles checkout and would dangle once copied somewhere else.
if [[ -d "${real_config_home}" ]]
then
  cp -RL "${real_config_home}/." "${config_home}/homebrew/"
fi
export XDG_CONFIG_HOME="${config_home}"

# A Homebrew without `brew trust` does not require tap trust, so there is
# nothing to grant.
if brew commands --quiet | grep -qx trust
then
  brew trust --tap "${tap}" >/dev/null
fi

failed=0

# Homebrew reports an unreadable tap as a warning and still exits 0, so a
# check that read nothing would count as a pass. Treat the skip notice as a
# failure, whichever reason Homebrew gives for it.
#
# The outcome is recorded in `failed` rather than returned, so that the caller
# needs no `||` and `set -e` stays in force between the checks. That way one
# commit attempt surfaces every problem instead of stopping at the first.
run_check() {
  local status
  set +e
  "$@" 2>&1 | tee "${check_log}"
  status="${PIPESTATUS[0]}"
  set -e
  if grep -qF "Skipping ${tap}" "${check_log}"
  then
    echo "Error: '$*' skipped ${tap} and checked nothing." >&2
    failed=1
  elif [[ "${status}" -ne 0 ]]
  then
    failed=1
  fi
}

run_check brew style "${tap}"
run_check brew readall --aliases --os=all --arch=all "${tap}"
run_check brew audit --except=installed --tap "${tap}"

exit "${failed}"
