# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'F1 Almanac' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for F1 Almanac
 pod 'Swinject'

  target 'F1 AlmanacTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'F1 AlmanacUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
  end
end
