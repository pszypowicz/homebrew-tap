cask "cyclist" do
  version "0.8.2"
  sha256 "fa40dee6c3fe6bf40c3bd2cd3303313f2676f87f8bc3a0c47587019fa200b2d2"

  url "https://github.com/pszypowicz/cyclist/releases/download/v#{version}/Cyclist.zip"
  name "Cyclist"
  desc "Text-only Cmd+Tab app switcher with instant Space navigation"
  homepage "https://github.com/pszypowicz/cyclist"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "Cyclist.app"

  postflight do
    system_command "open", args: ["/Applications/Cyclist.app"]
  end

  uninstall quit:       "cz.szypowi.cyclist",
            login_item: "Cyclist"

  zap trash: [
    "~/.config/cyclist",
    "~/Library/Logs/Cyclist.log",
    "~/Library/Preferences/cz.szypowi.cyclist.plist",
  ]
end
