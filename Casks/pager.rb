cask "pager" do
  version "0.1.3"
  sha256 "be2ab5d96939dbe6c8598dc68b4e3c18e726d0bf4b2481fb85cdb82ae782c0fb"

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
