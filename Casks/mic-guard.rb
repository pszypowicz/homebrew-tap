cask "mic-guard" do
  version "0.16.0"
  sha256 "eb64b4f2c1431ef4bae0f4471c7953f630c3bb632295cb08920adb8352024330"

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
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "/Applications/MicGuard.app"]
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
