# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

def default_pods
  pod 'SCrypto', '2.0.0'
end

target 'ImgFlo-iOS' do
  platform :ios, '9.0'
  use_frameworks!

  default_pods

  target 'ImgFlo-iOSTests' do
    inherit! :search_paths
    testing_pods
  end

end

target 'ImgFlo-Mac' do
  platform :osx, '10.11'
  use_frameworks!

  default_pods

  target 'ImgFlo-MacTests' do
    inherit! :search_paths
    testing_pods
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
