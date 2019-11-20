#
# Be sure to run `pod lib lint EasyStartGuide.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EasyStartGuide'
  s.version          = '0.1.1'
  s.summary          = 'A library for easy creating the start tutorial for new users.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
If you want to create a start guide for your new users, this library helps you to do it easy!
All you need is to install it with CocoaPods and get started with perfect tutorial on Github or CocoaPods!
                       DESC

  s.homepage         = 'https://github.com/BardRedStar/EasyStartGuide'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BardRedStar' => 'den.kovalev999@gmail.com' }
  s.source           = { :git => 'https://github.com/BardRedStar/EasyStartGuide.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'
  s.source_files = 'EasyStartGuide/Classes/**/*'
  
  # s.resource_bundles = {
  #   'EasyStartGuide' => ['EasyStartGuide/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
