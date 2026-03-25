cask "mic-guard" do
  version "0.15.0"
  sha256 "ee413fa8aac24e5cf260a97fd46906eac8828f35f6ed405f9adc0821d3cd7c67"

  url "https://github.com/pszypowicz/MicGuard/releases/download/v#{version}/MicGuard.zip"
  name "MicGuard"
  desc "Prevents Bluetooth devices from hijacking the default microphone"
  homepage "https://github.com/pszypowicz/MicGuard"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "MicGuard.app"
  binary "bin/mic-guard"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "/Applications/MicGuard.app"]
    system_command "open", args: ["/Applications/MicGuard.app"]
  end

  uninstall quit:       "com.pszypowicz.MicGuard",
            login_item: "MicGuard",
            on_upgrade: :quit

  zap trash: [
    "~/.config/mic-guard",
    "~/Library/Caches/com.pszypowicz.MicGuard",
  ]
end
