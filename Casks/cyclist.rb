cask "cyclist" do
  version "0.3.0"
  sha256 "ffb0cc551ade7fad547e4829534dfe39d14d9b41147fafa50215e06f2f6f0372"

  url "https://github.com/pszypowicz/cyclist/releases/download/v#{version}/Cyclist.zip"
  name "Cyclist"
  desc "Text-only Cmd+Tab app switcher with instant Space navigation"
  homepage "https://github.com/pszypowicz/cyclist"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

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
