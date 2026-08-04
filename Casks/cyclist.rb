cask "cyclist" do
  version "0.8.3"
  sha256 "9d1ff4124ce8eb99a0ed8368834ba6b269b52dffd64ab684fa9aee878433e9ba"

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
