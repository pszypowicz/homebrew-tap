cask "aerospace-bsp" do
  # Versioning scheme: <upstream-anchor>-bsp.<N>. <anchor> is the next upstream
  # tag this fork is heading toward; <N> is the tap release counter, bumped on
  # every published artifact. Homebrew compares "bsp.5 > bsp.4" correctly so
  # users get upgrades on `brew upgrade`. No livecheck because fork releases
  # ship at the author's discretion - auto-tracking would silently move
  # testers onto untested binaries.
  version "0.21.0-bsp.3"
  sha256 "820ebf032336413abce0fdb837678e4d489752ee95dd0ebc2fbbf91ca7acf718"

  url "https://github.com/pszypowicz/AeroSpace/releases/download/v#{version}/AeroSpace-v#{version}.zip"
  name "AeroSpace (BSP fork)"
  desc "AeroSpace fork: BSP normalization, per-workspace toggling, resize fixes"
  homepage "https://github.com/pszypowicz/AeroSpace"

  conflicts_with cask: "nikitabobko/tap/aerospace"
  depends_on macos: :sonoma

  app "AeroSpace-v#{version}/AeroSpace.app"
  binary "AeroSpace-v#{version}/bin/aerospace"
  binary "AeroSpace-v#{version}/shell-completion/zsh/_aerospace",
         target: "#{HOMEBREW_PREFIX}/share/zsh/site-functions/_aerospace"
  binary "AeroSpace-v#{version}/shell-completion/bash/aerospace",
         target: "#{HOMEBREW_PREFIX}/etc/bash_completion.d/aerospace"
  binary "AeroSpace-v#{version}/shell-completion/fish/aerospace.fish",
         target: "#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/aerospace.fish"

  Dir["#{staged_path}/AeroSpace-v#{version}/manpage/*"].each { |man| manpage man }

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AeroSpace.app"]
    system_command "/usr/bin/xattr",
                   args: ["-d", "com.apple.quarantine", "#{staged_path}/AeroSpace-v#{version}/bin/aerospace"]
  end

  uninstall quit:       "bobko.aerospace",
            login_item: "AeroSpace"

  zap trash: [
    "~/.config/aerospace",
    "~/Library/Caches/bobko.aerospace",
    "~/Library/Logs/AeroSpace",
  ]
end
