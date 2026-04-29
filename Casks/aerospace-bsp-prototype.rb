cask "aerospace-bsp-prototype" do
  version "2026.04.29"
  sha256 "78244d8d69ec01348950ec98bcb772bfd6672119940cce6ddc23dc35e336654d"

  url "https://github.com/pszypowicz/AeroSpace/releases/download/prototype-260-#{version.to_s.tr(".", "-")}/AeroSpace-prototype-260-#{version.to_s.tr(".", "-")}.zip"
  name "AeroSpace (BSP / per-workspace prototype)"
  desc "Prototype AeroSpace fork: BSP normalization + per-workspace toggle"
  homepage "https://github.com/pszypowicz/AeroSpace/pull/4"

  conflicts_with cask: "nikitabobko/tap/aerospace"
  # Pinned to a specific prototype build by design. Bump version + sha256 +
  # update URL when a newer prototype-260-YYYY-MM-DD release ships. No
  # livecheck because prototype builds are pre-releases that ship at the
  # author's discretion; auto-tracking would silently move testers to
  # untested binaries.

  depends_on macos: ">= :sonoma"

  app "AeroSpace.app"
  binary "aerospace"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AeroSpace.app"]
  end

  uninstall quit:       "bobko.aerospace",
            login_item: "AeroSpace"

  zap trash: [
    "~/.config/aerospace",
    "~/Library/Caches/bobko.aerospace",
    "~/Library/Logs/AeroSpace",
  ]
end
