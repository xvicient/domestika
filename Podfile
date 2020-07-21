min_ios_version = '13.0'
platform :ios, min_ios_version
inhibit_all_warnings!

def common
  use_frameworks!
end

target 'Domestika' do
  common
  pod 'Swinject', '~> 2.7.1'
  pod 'SnapKit', '~> 5.0.1'
  pod 'SwiftLint', '~> 0.39'
  pod 'Nuke', '~> 9.1.1'
end

target 'DomestikaTests' do
  common
end

workspace 'Domestika'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    # Enable Bitcode
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'YES'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = min_ios_version
    end
  end
end
