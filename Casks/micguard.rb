cask "micguard" do
  version "1.1.1"
  sha256 "7159a2eb88fb05e6979099bb6ffd2a804ddc282e46b3416ecaa310635f2b3cb9"

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
