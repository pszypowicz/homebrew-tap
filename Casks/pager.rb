cask "pager" do
  version "0.1.1"
  sha256 "7ae81a7be8558640bf9a9acf82608877465b4cad493a6db6c99e05c59339dcd2"

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
