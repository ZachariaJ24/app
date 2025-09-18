import UIKit
import WebKit

protocol WebViewManagerDelegate: AnyObject {
    func webViewDidStartLoading()
    func webViewDidFinishLoading()
    func webViewDidFailLoading(error: Error)
    func webViewDidUpdateTitle(_ title: String?)
    func webViewShouldOpenExternalURL(_ url: URL) -> Bool
}

class WebViewManager: NSObject {
    
    // MARK: - Properties
    weak var delegate: WebViewManagerDelegate?
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    private var progressObservation: NSKeyValueObservation?
    
    // MARK: - Initialization
    override init() {
        super.init()
        setupWebView()
    }
    
    // MARK: - Setup
    private func setupWebView() {
        let configuration = AppConfigManager.shared.getWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        // Setup progress observation
        progressObservation = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] _, change in
            DispatchQueue.main.async {
                self?.updateProgress(change.newValue ?? 0.0)
            }
        }
    }
    
    // MARK: - Public Methods
    func getWebView() -> WKWebView {
        return webView
    }
    
    func loadURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func loadURL(_ url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func reload() {
        webView.reload()
    }
    
    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    func canGoBack() -> Bool {
        return webView.canGoBack
    }
    
    func canGoForward() -> Bool {
        return webView.canGoForward
    }
    
    func getCurrentURL() -> URL? {
        return webView.url
    }
    
    func getCurrentTitle() -> String? {
        return webView.title
    }
    
    func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)? = nil) {
        webView.evaluateJavaScript(javaScriptString, completionHandler: completionHandler)
    }
    
    func clearCache() {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date) {
            print("WebView cache cleared")
        }
    }
    
    // MARK: - Private Methods
    private func updateProgress(_ progress: Float) {
        // Progress will be handled by the view controller
        // This method can be overridden by subclasses
    }
}

// MARK: - WKNavigationDelegate
extension WebViewManager: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        delegate?.webViewDidStartLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        delegate?.webViewDidFinishLoading()
        delegate?.webViewDidUpdateTitle(webView.title)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        delegate?.webViewDidFailLoading(error: error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        delegate?.webViewDidFailLoading(error: error)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        
        // Handle external links
        if url.scheme == "http" || url.scheme == "https" {
            // Check if it's an external link
            if let host = url.host, !host.contains("secretchelsociety.com") {
                // Ask delegate if we should open external URL
                if delegate?.webViewShouldOpenExternalURL(url) == true {
                    decisionHandler(.allow)
                } else {
                    decisionHandler(.cancel)
                }
                return
            }
        }
        
        // Handle other schemes
        if url.scheme != "http" && url.scheme != "https" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
}

// MARK: - WKUIDelegate
extension WebViewManager: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // Handle window.open() calls
        if let url = navigationAction.request.url {
            if delegate?.webViewShouldOpenExternalURL(url) == true {
                // Create a new web view or open in Safari
                let newWebView = WKWebView(frame: .zero, configuration: configuration)
                newWebView.load(URLRequest(url: url))
                return newWebView
            }
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        })
        
        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            topViewController.present(alert, animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionHandler(false)
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler(true)
        })
        
        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            topViewController.present(alert, animated: true)
        }
    }
}
