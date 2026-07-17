cask "cyclist" do
  version "0.4.1"
  sha256 "0c9c118da603ec12e6d585d45f0a5337030d11a9b319a50f00ed4cd5b1956b81"

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
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "/Applications/Cyclist.app"]
    system_command "open", args: ["/Applications/Cyclist.app"]
  end

  uninstall quit:       "io.github.pszypowicz.Cyclist",
            login_item: "Cyclist"

  zap trash: [
    "~/.config/cyclist",
    "~/Library/Logs/Cyclist.log",
    "~/Library/Preferences/io.github.pszypowicz.Cyclist.plist",
  ]
end
