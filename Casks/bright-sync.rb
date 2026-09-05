cask "bright-sync" do
  version "0.6.0"
  sha256 "f035d069a6413cc035fe656653ce33d48352ee1a9e99bab9abf3f09c2d1c72cd"

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

  postflight_steps do
    run "/usr/bin/open", args: ["-g", "{{appdir}}/BrightSync.app"]
  end

  uninstall quit:       "cz.szypowi.brightsync",
            login_item: "BrightSync"

  zap trash: [
    "~/.config/brightsync",
    "~/Library/Preferences/cz.szypowi.brightsync.plist",
  ]
end
