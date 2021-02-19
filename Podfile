inhibit_all_warnings!
use_frameworks!

platform :ios, '11.0'

def mainPods
  # ui
  pod 'Tabman', '~> 2.10.0'
  pod 'ShimmerSwift'
  pod 'NVActivityIndicatorView'
  
  # network
  pod 'Moya'
  pod 'SwiftyJSON', '~> 5.0'
  pod 'Kingfisher'
  
  # helpers
  pod 'TinyConstraints', '~> 4.0.1'
  pod 'SwiftDate'
  pod 'R.swift'

  # utility
  pod 'SwiftLint'
end

target 'UITabsDemo' do
  mainPods
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
end
