cask "mic-guard" do
  version "0.10.0"
  sha256 "b1729b5770fdbc5a31d570b2fa7e2a90095c28de4961e0d34030f604c547d5cb"

  url "https://github.com/pszypowicz/MicGuard/releases/download/v#{version}/MicGuard.zip"
  name "MicGuard"
  desc "Prevents Bluetooth devices from hijacking the default macOS microphone"
  homepage "https://github.com/pszypowicz/MicGuard"

  depends_on macos: ">= :sequoia"

  app "MicGuard.app"
  binary "bin/mic-guard"

  postflight do
    system_command "/usr/bin/pkill", args: ["-x", "MicGuard"], must_succeed: false
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "/Applications/MicGuard.app"]
    system_command "open", args: ["/Applications/MicGuard.app"]
  end

  zap trash: "~/.config/mic-guard"
end
