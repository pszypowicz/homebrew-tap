cask "micguard@beta" do
  version "1.1.0"
  sha256 "610242a5b9b9b4cfaa20ebf1e7f83b2617d8c2e5b28b4064cde10c55a1670bc9"

  url "https://github.com/pszypowicz/MicGuard/releases/download/v#{version}/MicGuard.zip"
  name "MicGuard"
  desc "Prevents Bluetooth devices from hijacking the default microphone"
  homepage "https://github.com/pszypowicz/MicGuard"

  # Follows the newest release, pre-releases included.
  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-(?:alpha|beta|rc)\.\d+)?)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  conflicts_with cask: "micguard"
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
