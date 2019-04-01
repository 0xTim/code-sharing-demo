Pod::Spec.new do |s|
  s.name         = "RemindersCore"
  s.version      = "0.0.1"
  s.summary      = "Reminders Core for cross-platform sharing"
  s.description  = <<-DESC
                    iOS Podspec for RemindersCore for sharing between iOS and Server
                   DESC

  s.homepage     = "https://bitbucket.org/brokenhandsio/CodeSharing"
  s.license      = "None"
  s.author       = "Tim Condon"
  s.platform     = :ios, "12.0"

  s.source       = { :git => "git@bitbucket.org:brokenhandsio/CodeSharing.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/RemindersCore/**/*.swift"
  s.swift_version = '5.0'
end
