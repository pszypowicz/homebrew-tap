cask "mic-guard" do
  version "0.6.1"
  sha256 "6a2267b20a05f599f37eb692882c801522a37b88ea6bf83ac2aa248605510c17"

  url "https://github.com/pszypowicz/MicGuard/releases/download/v#{version}/MicGuard.zip"
  name "MicGuard"
  desc "Prevents Bluetooth devices from hijacking the default macOS microphone"
  homepage "https://github.com/pszypowicz/MicGuard"

  depends_on macos: ">= :sequoia"

  app "MicGuard.app"
  binary "bin/mic-guard"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "/Applications/MicGuard.app"]
    system_command "open", args: ["/Applications/MicGuard.app"]
  end

  zap trash: "~/.config/mic-guard"
end
