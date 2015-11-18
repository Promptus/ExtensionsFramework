Pod::Spec.new do |s|
  s.name         = "ExtensionsFramework"
  s.version      = "0.0.1"
  s.summary      = "A collection of Objective-C/Swift extensions"

  s.description  = <<-DESC
                   A collection of Objective-C/Swift extension categories.
                   DESC
  s.homepage     = "https://github.com/Promptus/ExtensionsFramework.git"
  s.license      = 'MIT'
  s.author       = { "Lars Kuhnt" => "lars.kuhnt@gmail.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/Promptus/ExtensionsFramework.git" }
  s.source_files = 'ExtensionsFramework', 'ExtensionsFramework/**/*.{h,m,swift}'
  s.requires_arc = true

end
