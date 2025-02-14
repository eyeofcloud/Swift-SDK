workspace 'EyeofcloudDemo.xcworkspace'

#source 'https://gitee.com/eyeofcloud/swift-sdk.git'


def analytics_pods
#  pod 'Amplitude-iOS'
#  pod 'Google/Analytics'
#  pod 'Localytics'
#  pod 'Mixpanel-swift', '2.5.7'
end

def linter_pods
  # ignore all warnings from all dependencies
  inhibit_all_warnings!
  pod 'SwiftLint', '0.43.1'
end

def common_test_pods
  pod 'OCMock', '3.7.1'
end

target 'POC' do
  project 'EyeofcloudDemo.xcodeproj/'
  platform :ios, '11.0'
  use_frameworks!
  analytics_pods
  linter_pods
#  pod 'EyeofcloudSwiftSDK', '~> 3.10.2'
end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
            # fix OCMock old iOS8 target warning
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        end
    end
end

