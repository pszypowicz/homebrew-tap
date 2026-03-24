cask "mic-guard" do
  version "0.14.0"
  sha256 "72f3e49efdcab72047316e218495c48859fd8261d5b36a3b2fc852cb9ba87489"

  url "https://github.com/pszypowicz/MicGuard/releases/download/v#{version}/MicGuard.zip"
  name "MicGuard"
  desc "Prevents Bluetooth devices from hijacking the default macOS microphone"
  homepage "https://github.com/pszypowicz/MicGuard"

  depends_on macos: ">= :sequoia"

  app "MicGuard.app"
  binary "bin/mic-guard"

  uninstall quit:       "com.pszypowicz.MicGuard",
            on_upgrade: :quit

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "/Applications/MicGuard.app"]
    system_command "open", args: ["/Applications/MicGuard.app"]
  end

  zap trash: "~/.config/mic-guard"
end
