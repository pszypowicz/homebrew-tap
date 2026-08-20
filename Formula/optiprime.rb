class Optiprime < Formula
  desc "Terminal UI for keeping a directory of Azure DevOps repositories in sync"
  homepage "https://github.com/pszypowicz/optiprime"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pszypowicz/optiprime/releases/download/v0.3.0/optiprime_0.3.0_darwin_arm64.tar.gz"
      sha256 "c7cdd669c46f3e4d87738af8ed9f0dbebfb6e951cb8292ba48d379d29027aa32"
    else
      url "https://github.com/pszypowicz/optiprime/releases/download/v0.3.0/optiprime_0.3.0_darwin_amd64.tar.gz"
      sha256 "0dd23e18ed5599a46a58b08f52ccc118bde3044c58707ada569d33208de101da"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pszypowicz/optiprime/releases/download/v0.3.0/optiprime_0.3.0_linux_arm64.tar.gz"
      sha256 "a4457889ea8eaa500a634cee7ba5b81547a6aed90677d0f2bca5d898044b36da"
    else
      url "https://github.com/pszypowicz/optiprime/releases/download/v0.3.0/optiprime_0.3.0_linux_amd64.tar.gz"
      sha256 "be3928c73228e1477410fd724f596d01fcd98374a7c731bafe947e4e995de9ce"
    end
  end

  def install
    bin.install "optiprime"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/optiprime --version")
  end
end
