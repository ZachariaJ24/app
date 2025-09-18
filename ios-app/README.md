# Midnight Studios INTL iOS App

This is a React Native iOS app that displays the Secret Chelsea Society website (www.secretchelsociety.com) in a native WebView for Midnight Studios INTL.

## Features

- Native iOS app wrapper for the website
- WebView with proper configuration for optimal website display
- App permissions configured for web content
- Splash screen with Midnight Studios INTL branding
- iPhone and iPad support

## Prerequisites

To build and run this iOS app, you need:

1. **macOS**: This project requires macOS to build iOS apps
2. **Xcode**: Install from Mac App Store (version 12.0 or higher)
3. **CocoaPods**: Install via `sudo gem install cocoapods`
4. **Node.js**: Version 14 or higher
5. **iOS Simulator or iOS Device**: For testing

## Setup Instructions

### 1. Install Dependencies

```bash
# Navigate to the project directory
cd ios-app

# Install Node.js dependencies
yarn install

# Install iOS dependencies (CocoaPods)
cd ios && pod install && cd ..
```

### 2. Running the App

#### Option A: Using React Native CLI
```bash
# Start the Metro bundler
npx react-native start

# In a new terminal, run on iOS simulator
npx react-native run-ios
```

#### Option B: Using Xcode
1. Open `ios/SecretChelseaSocietyApp.xcworkspace` in Xcode
2. Select your target device/simulator
3. Press the "Run" button (⌘+R)

## App Configuration

### WebView Configuration
The app is configured to display `https://www.secretchelsociety.com` with:
- JavaScript enabled
- DOM storage enabled
- Proper user agent string (MidnightStudiosINTL/1.0)
- Full-screen video support
- Inline media playback
- Third-party cookies enabled

### App Info
- **App Name**: Midnight Studios INTL
- **Bundle ID**: secretchelsocietyintl.scs
- **Display Name**: Midnight Studios INTL
- **Version**: 1.0

### Network Security
The app includes proper App Transport Security (ATS) configuration to allow loading of the website content.

## Troubleshooting

### Common Pod Issues
If you encounter pod-related errors:

1. **Clean and reinstall pods**:
   ```bash
   cd ios
   rm -rf Pods
   rm Podfile.lock
   pod deintegrate
   pod install
   ```

2. **Clear React Native cache**:
   ```bash
   npx react-native start --reset-cache
   ```

3. **Clean Xcode build**:
   - In Xcode: Product → Clean Build Folder (⌘+Shift+K)

### Xcode Issues
- Make sure you're opening the `.xcworkspace` file, not `.xcodeproj`
- Check that your iOS deployment target is compatible (iOS 11.0+)
- Verify your Apple Developer account is set up if testing on physical device

## Project Structure

```
ios-app/
├── App.tsx                    # Main React Native component
├── index.js                   # App entry point
├── app.json                   # App configuration
├── package.json               # Node.js dependencies
├── metro.config.js            # Metro bundler configuration
├── babel.config.js            # Babel configuration
└── ios/                       # Native iOS project
    ├── Podfile                # CocoaPods dependencies
    ├── SecretChelseaSocietyApp.xcodeproj/  # Xcode project
    ├── SecretChelseaSocietyApp.xcworkspace/ # Xcode workspace (use this!)
    └── SecretChelseaSocietyApp/            # iOS app source
        ├── AppDelegate.h
        ├── AppDelegate.mm
        ├── main.m
        ├── Info.plist
        ├── LaunchScreen.storyboard
        └── Images.xcassets/
```

## Building for Production

### 1. Archive the App
1. Open `ios/SecretChelseaSocietyApp.xcworkspace` in Xcode
2. Select "Any iOS Device" as the target
3. Product → Archive
4. Use the Organizer to upload to App Store Connect

### 2. App Store Requirements
- Update app icons in `Images.xcassets/AppIcon.appiconset/`
- Configure app privacy settings
- Add app description and metadata
- Test on various iOS devices and versions

## Support

This app simply wraps the existing website in a native iOS container. For website-related issues, contact the Secret Chelsea Society web team.

For iOS app-specific issues:
- Check React Native documentation: https://reactnative.dev/
- Check React Native WebView documentation: https://github.com/react-native-webview/react-native-webview

## About Midnight Studios INTL

This iOS app is developed and maintained by Midnight Studios INTL for the Secret Chelsea Society project.