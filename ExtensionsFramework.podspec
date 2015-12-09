Pod::Spec.new do |s|

# 1
s.platform     = :ios
s.ios.deployment_target = '8.0'
s.name         = "ExtensionsFramework"
s.summary      = "A collection of Objective-C/Swift extensions"
s.requires_arc = true

# 2
s.version      = "0.0.1"

# 3
#if there is a license file available 
s.license     = { :type => "MIT", :file => "LICENSE"} 
#s.license      = 'MIT'

# 4
s.author       = { "Razvan Benga" => "razvanb@fortech.ro" }

# 5
s.homepage     = "https://github.com/Promptus/ExtensionsFramework.git"

# 6
s.source       = { :git => "https://github.com/Promptus/ExtensionsFramework.git", :tag => "#{s.version}"}

# 7
s.dependency 'Reachability', '~> 3.1.1'
s.dependency 'iCarousel',    '~> 1.7'

# 8
s.source_files = 'ExtensionsFramework', 'ExtensionsFramework/**/*.{h,m,swift}'

# 9
# s.resources


end
