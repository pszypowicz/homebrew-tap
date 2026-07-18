cask "cyclist" do
  version "0.6.3"
  sha256 "b7ef2dcf2c671d12d71627a9496a6686eeffa467cd4689daa38ea4251e99dbc5"

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
