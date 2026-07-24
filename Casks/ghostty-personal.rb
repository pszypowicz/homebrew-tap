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
  version "1.3.2-personal.2"
  sha256 "4b53ee981525cafb11e7b009a6358133db372ebb8df02776b10a81ef4e1950c7"

  url "https://github.com/pszypowicz/ghostty/releases/download/v#{version}/Ghostty-personal-v#{version}.zip"
  name "Ghostty (personal fork)"
  desc "Ghostty terminal fork with trackpad gestures and tmux socket actions"
  homepage "https://github.com/pszypowicz/ghostty"

  # The Sparkle updater is compiled out of this build, so in-app updates
  # cannot exist. It shares the com.mitchellh.ghostty bundle id, so it
  # cannot coexist with the official Ghostty casks or the older gestures
  # cask - install one or the other.
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

  # Ad-hoc signed builds are quarantined on download and have no Developer ID /
  # notarization, so clear the quarantine flag to let Gatekeeper launch it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Ghostty.app"]
  end

  uninstall quit: "com.mitchellh.ghostty"

  zap trash: [
    "~/.cache/ghostty",
    "~/.config/ghostty",
    "~/Library/Application Support/com.mitchellh.ghostty",
    "~/Library/Caches/com.mitchellh.ghostty",
    "~/Library/HTTPStorages/com.mitchellh.ghostty",
    "~/Library/Preferences/com.mitchellh.ghostty.plist",
    "~/Library/Saved Application State/com.mitchellh.ghostty.savedState",
    "~/Library/WebKit/com.mitchellh.ghostty",
  ]
end
