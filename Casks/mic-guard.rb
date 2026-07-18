cask "mic-guard" do
  version "0.18.0"
  sha256 "3120db41f8eae8128f0c84c6ffd5dbdba016ff877f035d2c5669e6defe0a253d"

  url "https://github.com/pszypowicz/MicGuard/releases/download/v#{version}/MicGuard.zip"
  name "MicGuard"
  desc "Prevents Bluetooth devices from hijacking the default microphone"
  homepage "https://github.com/pszypowicz/MicGuard"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "MicGuard.app"

  postflight do
    system_command "open", args: ["/Applications/MicGuard.app"]
  end

  uninstall quit:       "cz.szypowi.micguard",
            login_item: "MicGuard"

  zap trash: [
    "~/.config/mic-guard",
    "~/Library/Caches/cz.szypowi.micguard",
    "~/Library/Preferences/cz.szypowi.micguard.plist",
  ]
end
