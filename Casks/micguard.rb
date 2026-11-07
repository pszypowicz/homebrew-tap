cask "micguard" do
  version "1.1.0"
  sha256 "610242a5b9b9b4cfaa20ebf1e7f83b2617d8c2e5b28b4064cde10c55a1670bc9"

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
