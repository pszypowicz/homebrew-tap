cask "cyclist" do
  version "0.7.0"
  sha256 "20a5b6b059a0b2455040ea4b04af19a1fb28200a09ba6cda44c15589280cb133"

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
