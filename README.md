# Secret Chel Society - iOS App

This is the iOS version of the Secret Chel Society app, converted from the Android version.

## Project Structure

```
Secret Chel Society/
├── Sources/
│   ├── AppDelegate.swift              # Main app delegate
│   ├── SceneDelegate.swift            # Scene delegate for iOS 13+
│   ├── ViewControllers/
│   │   └── MainViewController.swift   # Main view controller with WebView
│   ├── Managers/
│   │   ├── AppConfigManager.swift     # App configuration manager
│   │   └── WebViewManager.swift       # WebView management
│   ├── Models/                        # Data models
│   ├── Views/                         # Custom views
│   ├── Extensions/                    # Swift extensions
│   └── Utils/                         # Utility classes
├── Assets.xcassets/                   # App assets and icons
├── Base.lproj/
│   ├── Main.storyboard               # Main storyboard
│   └── LaunchScreen.storyboard       # Launch screen storyboard
├── Info.plist                        # App configuration
└── Resources/                         # Additional resources
```

## Features

- **WebView Integration**: Full-featured WebView for displaying the web app
- **Native Navigation**: Native iOS navigation with back/forward support
- **External Link Handling**: Opens external links in Safari
- **Pull-to-Refresh**: Native pull-to-refresh functionality
- **Share Functionality**: Native iOS share sheet
- **Deep Link Support**: Handles custom URL schemes
- **Permission Handling**: Camera, microphone, and location permissions
- **Background Audio**: Supports background audio playback
- **WebRTC Support**: Camera and microphone access for web features

## Configuration

The app is configured through `AppConfigManager.swift` which contains all the settings from the original Android app:

- App name: "Secret Chel Society"
- Bundle ID: "midnightstudiosintl.scs"
- Version: 1.2.2
- Initial URL: "https://www.secretchelsociety.com/"
- User Agent: "Secret Chel Society"

## Requirements

- iOS 13.0+
- Xcode 15.0+
- Swift 5.0+

## Building the App

1. Open `Secret Chel Society.xcodeproj` in Xcode
2. Select your development team in the project settings
3. Build and run the project

## Key Differences from Android Version

1. **UI Framework**: Uses UIKit instead of Android Views
2. **Navigation**: Uses UINavigationController instead of Android Activities
3. **WebView**: Uses WKWebView instead of Android WebView
4. **Permissions**: Uses iOS permission system instead of Android permissions
5. **Storyboards**: Uses Interface Builder storyboards instead of XML layouts
6. **Swift**: Written in Swift instead of Java/Kotlin

## Architecture

The app follows the MVC (Model-View-Controller) pattern:

- **Model**: AppConfigManager for configuration data
- **View**: Storyboards and custom views
- **Controller**: MainViewController and other view controllers

The WebViewManager handles all WebView-related functionality and delegates events back to the view controller.

## Customization

To customize the app:

1. Update `AppConfigManager.swift` for configuration changes
2. Modify storyboards for UI changes
3. Update `Info.plist` for app metadata and permissions
4. Add new view controllers in the `ViewControllers` folder
5. Add custom views in the `Views` folder

## Dependencies

- WebKit framework for WebView functionality
- SafariServices framework for external link handling
- UIKit framework for UI components
