class AfmSummarize < Formula
  desc "Summarize stdin into one sentence with Apple's on-device Foundation Models"
  homepage "https://github.com/pszypowicz/afm-summarize"
  url "https://github.com/pszypowicz/afm-summarize/releases/download/v0.0.1/afm-summarize-0.0.1-arm64-macos.tar.gz"
  sha256 "e184d8ed1352916c5fde6c3f0de81d72c516cb2c10beafa2f6fc37bc027ad1d6"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    bin.install "afm-summarize"
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/afm-summarize --help")
  end
end
