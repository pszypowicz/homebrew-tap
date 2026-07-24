cask "ghostty-gestures" do
  # Ghostty fork with config-driven trackpad gestures (pinch, two-finger
  # double-tap), ad-hoc signed. Versioning scheme: <upstream-anchor>-gestures.<N>.
  # <anchor> is the upstream version this fork tracks; <N> is the tap release
  # counter, bumped on every published artifact. Homebrew compares
  # "gestures.2 > gestures.1" correctly so `brew upgrade` works. No livecheck:
  # fork releases ship at the author's discretion, so auto-tracking would
  # silently move testers onto untested binaries.
  version "1.3.2-gestures.5"
  sha256 "234c2450a64b1d1a65114f0ac48b4793bef7366b3ef20e63c4bb2219983f89d1"

  url "https://github.com/pszypowicz/ghostty/releases/download/v#{version}/Ghostty-gestures-v#{version}.zip"
  name "Ghostty (gestures fork)"
  desc "Ghostty terminal fork with config-driven trackpad gestures"
  homepage "https://github.com/pszypowicz/ghostty"

  # Ad-hoc signed fork, so no Sparkle auto-updates. It also shares the
  # com.mitchellh.ghostty bundle id, so it cannot coexist with the official
  # Ghostty casks - install one or the other.
  auto_updates false
  conflicts_with cask: [
    "ghostty",
    "ghostty@tip",
  ]
  depends_on macos: :ventura

  app "Ghostty-gestures-v#{version}/Ghostty.app"
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
