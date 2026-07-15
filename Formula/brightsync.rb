class Brightsync < Formula
  desc "Mirror built-in display brightness to external displays over DDC/CI"
  homepage "https://github.com/pszypowicz/brightsync"
  url "https://github.com/pszypowicz/brightsync/releases/download/v0.1.0/brightsync-0.1.0-arm64-macos.tar.gz"
  sha256 "66f1dedf091da99ffaac2e9d8fdca651937cb7d7325b4a579dd4b4559f33ca91"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  def install
    bin.install "brightsync"
  end

  service do
    run [opt_bin/"brightsync"]
    keep_alive true
    log_path var/"log/brightsync.log"
    error_log_path var/"log/brightsync.log"
  end

  test do
    assert_match "brightsync", shell_output("#{bin}/brightsync --help")
  end
end
