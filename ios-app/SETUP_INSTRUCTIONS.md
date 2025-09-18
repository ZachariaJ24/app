# Midnight Studios INTL iOS App Setup Instructions

## Important Note
This iOS app project was created in a Linux environment and needs to be completed on macOS with Xcode installed.

## What's Already Done

✅ React Native project structure created for Midnight Studios INTL
✅ WebView component configured to display www.secretchelsociety.com
✅ iOS project files and configurations created
✅ App icons and launch screen configured with Midnight Studios INTL branding
✅ Podfile created with necessary dependencies
✅ Info.plist configured with proper permissions and bundle ID

## Steps to Complete on macOS

### 1. Prerequisites
- macOS computer
- Xcode 12.0 or higher (from Mac App Store)
- Node.js 14+ and Yarn
- CocoaPods (`sudo gem install cocoapods`)

### 2. Setup Process

```bash
# 1. Copy this entire ios-app folder to your macOS machine

# 2. Navigate to the project
cd ios-app

# 3. Install Node.js dependencies
yarn install

# 4. Install iOS dependencies
cd ios
pod install
cd ..

# 5. Run the app
npx react-native run-ios
```

### 3. If You Encounter Pod Issues

The current Podfile might need adjustments for newer React Native versions. If `pod install` fails:

1. **Update to modern Podfile** (recommended):
```ruby
require_relative '../node_modules/react-native/scripts/react_native_pods'
require_relative '../node_modules/@react-native-community/cli-platform-ios/native_modules'

platform :ios, '11.0'
install! 'cocoapods', :deterministic_uuids => false

target 'SecretChelseaSocietyApp' do
  config = use_native_modules!

  use_react_native!(
    :path => config[:reactNativePath],
    :hermes_enabled => true,
    :fabric_enabled => false,
    :flipper_configuration => FlipperConfiguration.disabled,
    :app_path => "#{Pod::Config.instance.installation_root}/.."
  )

  target 'SecretChelseaSocietyAppTests' do
    inherit! :complete
  end

  post_install do |installer|
    react_native_post_install(
      installer,
      :mac_catalyst_enabled => false
    )
  end
end
```

2. **Clean and retry**:
```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod install
```

### 4. Opening in Xcode

**Important**: Always open `ios/SecretChelseaSocietyApp.xcworkspace`, NOT the `.xcodeproj` file.

### 5. Testing the App

The app should load and display the Secret Chelsea Society website in a full-screen WebView with Midnight Studios INTL branding.

## App Features

- ✅ Displays www.secretchelsociety.com
- ✅ Full-screen WebView experience
- ✅ Proper iOS navigation
- ✅ Optimized for iPhone and iPad
- ✅ App Transport Security configured
- ✅ Native iOS app wrapper with Midnight Studios INTL branding
- ✅ Bundle ID: secretchelsocietyintl.scs

## Troubleshooting

### Common Issues:
1. **"Command not found" errors**: Install Xcode Command Line Tools
2. **Pod install fails**: Update CocoaPods and retry
3. **Build errors**: Clean project in Xcode (⌘+Shift+K)
4. **Website not loading**: Check network permissions in Info.plist

### Fix Commands:
```bash
# Reset React Native cache
npx react-native start --reset-cache

# Rebuild pods
cd ios && pod deintegrate && pod install && cd ..

# Clean everything
rm -rf node_modules yarn.lock ios/Pods ios/Podfile.lock
yarn install
cd ios && pod install && cd ..
```

## Next Steps for Production

1. **App Icons**: Replace placeholders in `ios/SecretChelseaSocietyApp/Images.xcassets/AppIcon.appiconset/`
2. **Launch Screen**: Customize `ios/SecretChelseaSocietyApp/LaunchScreen.storyboard` (already updated with Midnight Studios INTL branding)
3. **App Store**: Configure app metadata and descriptions for Midnight Studios INTL
4. **Testing**: Test on various iOS devices and versions
5. **Deployment**: Archive and upload to App Store Connect

## App Details
- **Developer**: Midnight Studios INTL
- **App Name**: Midnight Studios INTL
- **Bundle ID**: secretchelsocietyintl.scs
- **Target Website**: www.secretchelsociety.com
- **User Agent**: MidnightStudiosINTL/1.0

This app creates a native iOS wrapper around your website, giving users the experience of a native app while displaying your web content under the Midnight Studios INTL brand.