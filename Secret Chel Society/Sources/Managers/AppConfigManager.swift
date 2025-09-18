import Foundation
import UIKit

class AppConfigManager {
    static let shared = AppConfigManager()
    
    // MARK: - Configuration Properties
    let appName = "Secret Chel Society"
    let bundleId = "midnightstudiosintl.scs"
    let version = "1.2.2"
    let buildNumber = 13
    let initialURL = "https://www.secretchelsociety.com/"
    
    // User Agent
    let userAgent = "Secret Chel Society"
    
    // App Settings
    let keepScreenOn = true
    let enablePullToRefresh = true
    let enableSwipeGestures = false
    let showActionBar = false
    let showNavigationMenu = false
    let androidFullScreen = true
    let iosFullScreenWebview = true
    
    // Theme Settings
    let iosTheme = "default"
    let iosDarkMode = "auto"
    let iosStatusBarStyle = "auto"
    let iosEnableBlurInStatusBar = true
    let iosEnableOverlayInStatusBar = true
    let iosStatusBarBackgroundColor = "#ffffffff"
    let iosStatusBarBackgroundColorDark = "#000000"
    
    // Colors
    let iosTintColor = "#0E0D08"
    let iosTintColorDark = "#ffffff"
    let iosTitleColor = "#0E0D08"
    let iosTitleColorDark = "#ffffff"
    let iosNavigationBarTintColor = "#f8f8f8"
    let iosNavigationBarTintColorDark = "#202020"
    
    // Background Colors
    let iosSidebarBackgroundColor = "#f8f8f8"
    let iosSidebarBackgroundColorDark = "#202020"
    let iosSidebarTextColor = "#0E0D08"
    let iosSidebarTextColorDark = "#ffffff"
    
    // Tab Bar Colors
    let iosTabBarTintColor = "#f8f8f8"
    let iosTabBarTintColorDark = "#000000"
    let iosTabBarInactiveColor = "#A1A1A1"
    let iosTabBarInactiveColorDark = "#818181"
    
    // Activity Indicator
    let iosActivityIndicatorColor = "#808080"
    let iosActivityIndicatorColorDark = "#808080"
    
    // Permissions
    let usesGeolocation = false
    let iosLocationUsageDescription = ""
    let iosCameraUsageDescription = "This app needs access to camera to take photos and videos."
    let iosMicrophoneUsageDescription = "This app needs access to microphone to record audio."
    let iOSATTUserTrackingDescription = ""
    let iOSRequestATTConsentOnLoad = false
    
    // Background Audio
    let iosBackgroundAudio = true
    
    // WebRTC
    let enableWebRTCamera = true
    let enableWebRTCMicrophone = true
    
    // Languages
    let supportedLanguages = ["es-419", "fr"]
    
    private init() {}
    
    // MARK: - Helper Methods
    func getStatusBarStyle() -> UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .default
        } else {
            return .default
        }
    }
    
    func getNavigationBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        if #available(iOS 13.0, *) {
            appearance.backgroundColor = UIColor.systemBackground
            appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        } else {
            appearance.backgroundColor = UIColor.white
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        
        return appearance
    }
    
    func getTabBarAppearance() -> UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        if #available(iOS 13.0, *) {
            appearance.backgroundColor = UIColor.systemBackground
        } else {
            appearance.backgroundColor = UIColor.white
        }
        
        return appearance
    }
    
    func getWebViewConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        
        // Set user agent
        configuration.applicationNameForUserAgent = userAgent
        
        // Enable JavaScript
        configuration.preferences.javaScriptEnabled = true
        
        // Allow inline media playback
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        // Configure for WebRTC
        if enableWebRTCamera || enableWebRTCMicrophone {
            configuration.websiteDataStore = WKWebsiteDataStore.default()
        }
        
        return configuration
    }
}
