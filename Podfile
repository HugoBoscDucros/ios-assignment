# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'iOS-assignment' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  #pod 'RxCocoa'
  #pod 'RxSwift'
  pod 'SwiftGen'

  # Pods for iOS-assignment

  target 'iOS-assignmentTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOS-assignmentUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
