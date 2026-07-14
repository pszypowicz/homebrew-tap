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

# shellcheck disable=SC2329  # invoked via the EXIT trap
cleanup() {
  rm -f "${link}"
  rmdir "${link_dir}" 2>/dev/null || true
}
trap cleanup EXIT

mkdir -p "${link_dir}"
ln -sfn "${repo}" "${link}"

# Deprecated-but-still-loading API calls must fail here exactly as they do
# in CI, and a hook should not trigger a slow brew auto-update.
export HOMEBREW_DEVELOPER=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

# Run all three checks even after a failure so one commit attempt surfaces
# every problem.
failed=0
brew style "${tap}" || failed=1
brew readall --aliases --os=all --arch=all "${tap}" || failed=1
brew audit --except=installed --tap "${tap}" || failed=1

exit "${failed}"
