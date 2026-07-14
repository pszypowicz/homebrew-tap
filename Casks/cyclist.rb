cask "cyclist" do
  version "0.2.0"
  sha256 "d52b3154acdff7fe039ea927cea6968f6887385043e3684064653f5fb3f35329"

  url "https://github.com/pszypowicz/cyclist/releases/download/v#{version}/Cyclist.zip"
  name "Cyclist"
  desc "Text-only Cmd+Tab app switcher with instant Space navigation"
  homepage "https://github.com/pszypowicz/cyclist"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Cyclist.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "/Applications/Cyclist.app"]
    system_command "open", args: ["/Applications/Cyclist.app"]
  end

  uninstall quit:       "io.github.pszypowicz.Cyclist",
            login_item: "Cyclist"

  zap trash: [
    "~/Library/Logs/Cyclist.log",
    "~/Library/Preferences/io.github.pszypowicz.Cyclist.plist",
  ]
end
