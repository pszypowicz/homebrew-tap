class MicGuard < Formula
  desc "Prevents Bluetooth devices from hijacking the default macOS microphone"
  homepage "https://github.com/pszypowicz/MicGuard"
  url "https://github.com/pszypowicz/MicGuard.git",
      tag: "v0.1.0",
      using: :git
  version "0.1.0"
  license "MIT"

  depends_on :macos
  depends_on "switchaudio-osx"

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/MicGuard" => "mic-guard"

    # Create minimal .app bundle so macOS shows our icon in Login Items
    app = prefix/"MicGuard.app/Contents"
    app.mkpath
    (app/"MacOS").install_symlink bin/"mic-guard" => "MicGuard"
    (app/"Resources").install "Resources/MicGuard.icns"
    (app/"Info.plist").write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>MicGuard</string>
        <key>CFBundleIconFile</key>
        <string>MicGuard</string>
        <key>CFBundleIdentifier</key>
        <string>com.pszypowicz.mic-guard</string>
        <key>CFBundleName</key>
        <string>MicGuard</string>
        <key>CFBundleVersion</key>
        <string>#{version}</string>
        <key>LSUIElement</key>
        <true/>
      </dict>
      </plist>
    PLIST
  end

  service do
    run [opt_prefix/"MicGuard.app/Contents/MacOS/MicGuard"]
    keep_alive true
    run_at_load true
    log_path var/"log/mic-guard.log"
    error_log_path var/"log/mic-guard.log"
  end

  test do
    assert_match "MicGuard", shell_output("#{bin}/mic-guard --help 2>&1", 1)
  end
end
