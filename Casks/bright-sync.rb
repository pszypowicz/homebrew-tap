cask "bright-sync" do
  version "0.4.0"
  sha256 "bcb23d1eec6d5e1935134a99cb012e9f8a448f9140b18d2ab9c6663d1ae16c75"

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
