cask "sequester" do
  version "0.2.4"
  sha256 "da2e94a6a1813200fbf2fd90f5966cf63f513db45d34a28eb85350d56c17709b"

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
