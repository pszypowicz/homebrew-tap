cask "sequester" do
  version "0.2.7"
  sha256 "cabb035148b7acdfed05a255b16bdf159f6b3a86be50e78c38f67e19aa630289"

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

  postflight_steps do
    run "/usr/bin/open", args: ["{{appdir}}/Sequester.app"]
  end

  uninstall quit:       "cz.szypowi.sequester",
            login_item: "Sequester"

  zap trash: "~/Library/Containers/cz.szypowi.sequester"
end
