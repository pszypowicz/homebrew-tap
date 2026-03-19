cask "mic-guard" do
  version "0.12.0"
  sha256 "2d6f05cecef8285f5d48d7198b3ee7aa20abf6e5a81b25f4c96a171e66e55deb"

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
