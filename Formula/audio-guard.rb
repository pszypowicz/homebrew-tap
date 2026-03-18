class AudioGuard < Formula
  desc "Prevents Bluetooth devices from hijacking the default macOS microphone"
  homepage "https://github.com/pszypowicz/AudioGuard"
  url "https://github.com/pszypowicz/AudioGuard.git",
      tag: "v0.1.0",
      using: :git
  version "0.1.0"
  license "MIT"

  depends_on :macos
  depends_on "switchaudio-osx"

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/AudioGuard" => "audio-guard"
  end

  service do
    run [opt_bin/"audio-guard"]
    keep_alive true
    run_at_load true
    log_path var/"log/audio-guard.log"
    error_log_path var/"log/audio-guard.log"
  end

  test do
    assert_match "AudioGuard", shell_output("#{bin}/audio-guard --help 2>&1", 1)
  end
end
