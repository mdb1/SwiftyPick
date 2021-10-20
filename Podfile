platform :ios, '14.3'
use_frameworks!

# ignore all warnings from all dependencies
inhibit_all_warnings!

def app_pods
  pod 'SwiftGen', '6.4.0'
end

target 'SwiftyPick' do

  app_pods

end

target 'SwiftyPickTests' do
  app_pods
end

target 'SwiftyPickUITests' do

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if Gem::Version.new('9.0') > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.3'
      end
    end
  end
end
