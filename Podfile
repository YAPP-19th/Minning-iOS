# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'Minning'

project 'Minning/CommonSystem'
project 'Minning/DesignSystem.xcodeproj'
project 'Minning/SharedAssets.xcodeproj'

project 'Minning'

target 'Minning' do
  inhibit_all_warnings!
  use_frameworks!

  # Pods for Minning
  pod 'SnapKit'
  pod 'Alamofire'
  pod 'SDWebImage'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'Firebase/Auth'
  pod 'GoogleSignIn'
  pod 'SwiftyJSON'
  pod 'SwiftLint'
  pod 'Promises'
  pod 'Pageboy'
  pod 'lottie-ios'
  pod 'KakaoSDK'
  pod 'Reveal-SDK'

  target 'MinningTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MinningUITests' do
    # Pods for testing
  end

end

target 'DesignSystem' do
  project 'DesignSystem/DesignSystem'
  pod 'SnapKit'
  pod 'SwiftLint'
end

target 'CommonSystem' do
  project 'CommonSystem/CommonSystem'
  pod 'SwiftLint'
end

target 'SharedAssets' do
  project 'SharedAssets/SharedAssets'
  pod 'SwiftLint'
end
