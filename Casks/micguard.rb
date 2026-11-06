cask "micguard" do
  version "0.19.0"
  sha256 "073d4a13d2417f865b2cfcda6f84bbae57b241aad5180af4a0b4f496009d0bc6"

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
