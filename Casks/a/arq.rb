cask "arq" do
  version "7.32"
  sha256 "0e221bd17074d19ecf07fb2cf6eb9e1ff44400730f3d5013ed06101a7435cdd9"

  url "https://www.arqbackup.com/download/arqbackup/Arq#{version}.pkg"
  name "Arq"
  desc "Multi-cloud backup application"
  homepage "https://www.arqbackup.com/"

  livecheck do
    url "https://www.arqbackup.com/download/arqbackup/arq#{version.major}_release_notes.html"
    regex(/Version\s+v?(\d+(?:\.\d+)+)/i)
  end

  auto_updates true

  pkg "Arq#{version}.pkg"

  uninstall launchctl: [
              "com.haystacksoftware.arqagent",
              "com.haystacksoftware.ArqMonitor",
            ],
            quit:      "com.haystacksoftware.Arq",
            pkgutil:   "com.haystacksoftware.Arq",
            delete:    "/Applications/Arq.app"

  zap trash: [
    "/Library/Application Support/ArqAgent",
    "/Library/Application Support/ArqAgentAPFS",
    "~/Library/Application Support/Arq *",
    "~/Library/Arq *",
    "~/Library/Preferences/com.haystacksoftware.Arq.plist",
    "~/Library/Preferences/com.haystacksoftware.ArqMonitor.plist",
  ]
end
