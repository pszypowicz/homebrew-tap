cask "micguard" do
  version "1.1.2"
  sha256 "0ae90c47b836daeca16159bcc7c03f004d00632a2fa9fc1fc6da97b4dfe4ac52"

  url "https://github.com/pszypowicz/MicGuard/releases/download/v#{version}/MicGuard.zip"
  name "MicGuard"
  desc "Prevents Bluetooth devices from hijacking the default microphone"
  homepage "https://github.com/pszypowicz/MicGuard"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "micguard@beta"
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "MicGuard.app"

  uninstall quit:       "cz.szypowi.micguard",
            login_item: "MicGuard"

  zap trash: [
    "~/.config/mic-guard",
    "~/Library/Caches/cz.szypowi.micguard",
    "~/Library/Preferences/cz.szypowi.micguard.plist",
  ]
end
