cask "brightsync" do
  version "0.2.0"
  sha256 "82b93bbdb4517cc7ccef23acd38ddf0758218f4fd321d0086e41af988e279015"

  url "https://github.com/pszypowicz/brightsync/releases/download/v#{version}/Brightsync-#{version}.zip"
  name "Brightsync"
  desc "Mirror built-in display brightness to external displays over DDC/CI"
  homepage "https://github.com/pszypowicz/brightsync"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Brightsync.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/Brightsync.app"]
    system_command "/Applications/Brightsync.app/Contents/MacOS/brightsync", args: ["--autostart", "enable"]
  end

  uninstall_preflight do
    system_command "/Applications/Brightsync.app/Contents/MacOS/brightsync", args: ["--autostart", "disable"]
  end

  zap trash: "~/.config/brightsync"
end
