cask "pager" do
  version "0.1.0"
  sha256 "c1bbf07d70e757c095d9a9d5845076fbd66a0b676cd9c7c664d3f54789041638"

  url "https://github.com/pszypowicz/pager/releases/download/v#{version}/Pager.zip"
  name "Pager"
  desc "Click-to-focus, self-clearing notifications for tmux"
  homepage "https://github.com/pszypowicz/pager"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Pager.app"
  binary "#{appdir}/Pager.app/Contents/MacOS/pager", target: "pager"

  postflight do
    system_command "open", args: ["/Applications/Pager.app"]
  end

  uninstall quit:       "cz.szypowi.pager",
            login_item: "Pager"

  zap trash: [
    "~/Library/Caches/cz.szypowi.pager",
    "~/Library/Preferences/cz.szypowi.pager.plist",
  ]
end
