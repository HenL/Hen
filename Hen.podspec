Pod::Spec.new do |s|
  s.name         = "Hen"
  s.version      = "1.0"
  s.summary      = "Asynchronos image downloader with cache support as a small UIImageView extension written in Swift 2.1"
  s.homepage     = "https://github.com/HenL/Hen"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Hen Levy" => "www.hen@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/HenL/Hen.git", :tag => "1.0" }
  s.source_files = "Hen/Hen/*.swift"
end
