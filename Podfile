# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'OurApp'

project 'OurApp/CommonSystem'
project 'OurApp/DesignSystem.xcodeproj'
project 'OurApp/SharedAssets.xcodeproj'

project 'OurApp'

target 'OurApp' do
  inhibit_all_warnings!
  use_frameworks!

  # Pods for OurApp
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

  target 'OurAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OurAppUITests' do
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
