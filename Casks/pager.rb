cask "pager" do
  version "0.1.2"
  sha256 "16b75afb809ab3f6b7f77c01a4b5ab4783a4b1773c4867a1c057e5e1b9554126"

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
