cask "bright-sync" do
  version "0.5.0"
  sha256 "6aee916859ecdf75ca15e391284d703dc411c1b8113f2db5ede8535e787040f6"

  url "https://github.com/pszypowicz/BrightSync/releases/download/v#{version}/BrightSync-#{version}.zip"
  name "BrightSync"
  desc "Mirror built-in display brightness to external displays over DDC/CI"
  homepage "https://github.com/pszypowicz/BrightSync"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "BrightSync.app"
  # The app's own executable doubles as the `brightsync` CLI (--list,
  # --set-external, ...). Homebrew symlinks it onto PATH and removes it on
  # uninstall.
  binary "#{appdir}/BrightSync.app/Contents/MacOS/BrightSync", target: "brightsync"

  postflight do
    system_command "open", args: ["-g", "/Applications/BrightSync.app"]
  end

  uninstall quit:       "cz.szypowi.brightsync",
            login_item: "BrightSync"

  zap trash: [
    "~/.config/brightsync",
    "~/Library/Preferences/cz.szypowi.brightsync.plist",
  ]
end
