cask "sequester" do
  version "0.2.3"
  sha256 "f0dd20c3aded1793a5987e2a794073ff672eb449ea87c720e02e98a88be5f360"

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
