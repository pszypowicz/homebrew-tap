cask "bright-sync" do
  version "0.4.1"
  sha256 "81a7e8d9bb16ab1dce221d426146fef65e015b15dbc7255911cf71ca5a43dc09"

  url "https://github.com/pszypowicz/BrightSync/releases/download/v#{version}/BrightSync-#{version}.zip"
  name "BrightSync"
  desc "Mirror built-in display brightness to external displays over DDC/CI"
  homepage "https://github.com/pszypowicz/BrightSync"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "BrightSync.app"

  postflight do
    system_command "open", args: ["-g", "/Applications/BrightSync.app"]
  end

  uninstall quit:       "cz.szypowi.brightsync",
            login_item: "BrightSync"

  zap trash: [
    "~/.config/brightsync",
    "~/Library/Preferences/cz.szypowi.brightsync.plist",
  ]
end
