cask "sequester" do
  version "0.1.3"
  sha256 "ea3c8d38807d711d0a901c4da4368939aa42c413b8a4387b538a334bd2b029dc"

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
