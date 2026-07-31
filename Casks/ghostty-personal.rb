cask "ghostty-personal" do
  # Personal Ghostty fork build: config-driven trackpad gestures (pinch,
  # two-finger double-tap, swipes) plus the tmux_command keybind action,
  # with the Sparkle auto-update stack removed - updates ship through this
  # tap. Versioning scheme: <upstream-anchor>-personal.<N>. <anchor> is the
  # upstream version the fork tracks; <N> is the tap release counter,
  # bumped on every published artifact. Homebrew compares
  # "personal.2 > personal.1" correctly so `brew upgrade` works. No
  # livecheck: fork releases ship at the author's discretion, so
  # auto-tracking would silently move testers onto untested binaries.
  version "1.3.2-personal.5"
  sha256 "bd99edeb83278d77546b668a6bf57fd012f509ade9d295a6aa5ba5f187bf8d9a"

  url "https://github.com/pszypowicz/ghostty/releases/download/v#{version}/Ghostty-personal-v#{version}.zip"
  name "Ghostty (personal fork)"
  desc "Ghostty terminal fork with trackpad gestures and tmux socket actions"
  homepage "https://github.com/pszypowicz/ghostty"

  # The Sparkle updater is compiled out of this build, so in-app updates
  # cannot exist. The build is Developer ID signed and notarized under the
  # cz.szypowi.ghostty bundle id, so TCC grants survive upgrades. It still
  # cannot coexist with the official Ghostty casks or the older gestures
  # cask (all install Ghostty.app) - install one or the other.
  auto_updates false
  conflicts_with cask: [
    "ghostty",
    "ghostty@tip",
    "pszypowicz/tap/ghostty-gestures",
  ]
  depends_on macos: :ventura

  app "Ghostty-personal-v#{version}/Ghostty.app"
  bash_completion "#{appdir}/Ghostty.app/Contents/Resources/bash-completion/completions/ghostty.bash"
  fish_completion "#{appdir}/Ghostty.app/Contents/Resources/fish/vendor_completions.d/ghostty.fish"
  zsh_completion "#{appdir}/Ghostty.app/Contents/Resources/zsh/site-functions/_ghostty"

  uninstall quit: "cz.szypowi.ghostty"

  # App Support and Caches stay under com.mitchellh.ghostty (compiled-in
  # paths); Preferences, saved state, and CFNetwork/WebKit storage key off
  # the Info.plist bundle id, so both generations are listed.
  zap trash: [
    "~/.cache/ghostty",
    "~/.config/ghostty",
    "~/Library/Application Support/com.mitchellh.ghostty",
    "~/Library/Caches/com.mitchellh.ghostty",
    "~/Library/HTTPStorages/com.mitchellh.ghostty",
    "~/Library/HTTPStorages/cz.szypowi.ghostty",
    "~/Library/Preferences/com.mitchellh.ghostty.plist",
    "~/Library/Preferences/cz.szypowi.ghostty.plist",
    "~/Library/Saved Application State/com.mitchellh.ghostty.savedState",
    "~/Library/Saved Application State/cz.szypowi.ghostty.savedState",
    "~/Library/WebKit/com.mitchellh.ghostty",
    "~/Library/WebKit/cz.szypowi.ghostty",
  ]
end
