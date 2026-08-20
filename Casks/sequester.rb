cask "sequester" do
  version "0.2.6"
  sha256 "7a8001262c0c23194fcd0bb0a1d8aade3baaf0c2c4d3aee7396248af06df1417"

  url "https://github.com/pszypowicz/sequester/releases/download/v#{version}/Sequester.zip"
  name "Sequester"
  desc "Secure Enclave SSH agent"
  homepage "https://github.com/pszypowicz/sequester"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "Sequester.app"

  postflight do
    system_command "open", args: ["/Applications/Sequester.app"]
  end

  uninstall quit:       "cz.szypowi.sequester",
            login_item: "Sequester"

  zap trash: "~/Library/Containers/cz.szypowi.sequester"
end
