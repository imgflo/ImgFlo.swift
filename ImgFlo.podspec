Pod::Spec.new do |s|
  s.name         = "ImgFlo"
  s.version      = "0.2.5"
  s.summary      = "Conveniently produce authorized imgflo URLs."
  s.homepage     = "https://github.com/the-grid/ImgFlo.swift"
  s.license     = { :type => "MIT" }
  s.author             = { "Nick Velloff" => "nick.velloff@gmail.com" }
  s.social_media_url   = "https://twitter.com/nickvelloff"
  s.platform     = :osx, "10.11"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/the-grid/ImgFlo.swift.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "ImgFlo/**/*.swift"
  s.requires_arc = true
  s.dependency "SCrypto", "~> 1.0.2"
end