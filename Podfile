platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!

target 'ASLAdapter' do
  target 'ASLAdapterTests' do
    inherit! :search_paths
    pod 'libextobjc/EXTScope', '0.4.1'
    pod 'OCMock', '3.3.1'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    end
  end
end
