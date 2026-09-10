cask "sequester" do
  version "0.2.9"
  sha256 "f4e7067b68191965ab7a54970c9336187cb5204a70beb8174d81fe6a662b8496"

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

  uninstall quit:       "cz.szypowi.sequester",
            login_item: "Sequester"

  zap trash: "~/Library/Containers/cz.szypowi.sequester"
end
