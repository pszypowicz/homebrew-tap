cask "cyclist" do
  version "0.6.0"
  sha256 "e0ed849be7f5e36228528856d13cce9c1a0fa5e740e245aeff55242101da0753"

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
    "~/Library/Preferences/io.github.pszypowicz.Cyclist.plist",
  ]
end
