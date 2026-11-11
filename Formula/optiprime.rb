class Optiprime < Formula
  desc "Terminal UI for keeping a directory of Azure DevOps repositories in sync"
  homepage "https://github.com/pszypowicz/optiprime"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pszypowicz/optiprime/releases/download/v0.5.0/optiprime_0.5.0_darwin_arm64.tar.gz"
      sha256 "53f10fade6c8521522f0f1716cb9196f03d4373abe1f13fd01b30d82ce06cebe"
    else
      url "https://github.com/pszypowicz/optiprime/releases/download/v0.5.0/optiprime_0.5.0_darwin_amd64.tar.gz"
      sha256 "268bbb01e57936805a384d76e3fcc8eeced9ac30f47a761f888f59efdd241a10"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pszypowicz/optiprime/releases/download/v0.5.0/optiprime_0.5.0_linux_arm64.tar.gz"
      sha256 "bec3d0d15c73ec353be6f542216dfa1f0db3b51d56739cd6098f2bac7b9c46d2"
    else
      url "https://github.com/pszypowicz/optiprime/releases/download/v0.5.0/optiprime_0.5.0_linux_amd64.tar.gz"
      sha256 "0c6e0048182a7b3bc1f0da23c37fe51f6049854f9a6f1f0e509dcbd5d2a1a848"
    end
  end

  def install
    bin.install "optiprime"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/optiprime --version")
  end
end
