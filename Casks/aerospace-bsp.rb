cask "aerospace-bsp" do
  version "0.21.0-bsp.1"
  sha256 "ca850163b33bffa69dbd86f49e08c430fe2e568e6c3e107053178badcd0b4a1e"

  url "https://github.com/pszypowicz/AeroSpace/releases/download/v#{version}/AeroSpace-v#{version}.zip"
  name "AeroSpace (BSP fork)"
  desc "AeroSpace fork: BSP-shape normalization + per-workspace normalization toggling + resize stability fixes"
  homepage "https://github.com/pszypowicz/AeroSpace"

  conflicts_with cask: "nikitabobko/tap/aerospace"
  conflicts_with cask: "pszypowicz/tap/aerospace-bsp-prototype"

  # Versioning scheme: <upstream-anchor>-bsp.<N>. <anchor> is the next upstream
  # tag this fork is heading toward; <N> is the tap release counter, bumped on
  # every published artifact. Homebrew compares "bsp.5 > bsp.4" correctly so
  # users get upgrades on `brew upgrade`. No livecheck because fork releases
  # ship at the author's discretion - auto-tracking would silently move
  # testers onto untested binaries.

  depends_on macos: ">= :sonoma"

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
