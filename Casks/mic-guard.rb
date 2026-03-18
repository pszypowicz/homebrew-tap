cask "mic-guard" do
  version "0.2.1"
  sha256 :no_check

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
