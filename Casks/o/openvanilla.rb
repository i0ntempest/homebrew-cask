cask "openvanilla" do
  version "1.7.2,3416"
  sha256 "0697d4c5e4f33df02dbcabf630d9c1557b28c7add01133429d2d3c158b2b7c75"

  url "https://github.com/openvanilla/openvanilla/releases/download/#{version.csv.first}/OpenVanilla-Installer-Mac-#{version.csv.first}.zip",
      verified: "github.com/openvanilla/openvanilla/"
  name "OpenVanilla"
  desc "Provides common input methods"
  homepage "https://openvanilla.org/"

  livecheck do
    url "https://raw.githubusercontent.com/openvanilla/openvanilla/master/Source/Mac/OpenVanilla-Info.plist"
    strategy :xml do |xml|
      short_version = xml.elements["//key[text()='CFBundleShortVersionString']"]&.next_element&.text
      version = xml.elements["//key[text()='CFBundleVersion']"]&.next_element&.text
      next if short_version.blank? || version.blank?

      "#{short_version.strip},#{version.strip}"
    end
  end

  container nested: "OpenVanillaInstaller.app/Contents/Resources/NotarizedArchives/OpenVanilla-r#{version.csv.second}.zip"

  input_method "OpenVanilla.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.openvanilla.*.sfl*",
    "~/Library/Application Support/OpenVanilla",
    "~/Library/Preferences/org.openvanilla.*",
  ]

  caveats do
    logout
  end
end
