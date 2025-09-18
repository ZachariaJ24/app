import UIKit
import WebKit
import SafariServices

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var webViewManager: WebViewManager!
    private var progressView: UIProgressView!
    private var refreshControl: UIRefreshControl!
    private var activityIndicator: UIActivityIndicatorView!
    
    // Configuration
    private let config = AppConfigManager.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupWebView()
        loadInitialURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = config.appName
        
        // Setup navigation bar
        setupNavigationBar()
        
        // Setup progress view
        setupProgressView()
        
        // Setup activity indicator
        setupActivityIndicator()
        
        // Setup web view manager
        setupWebViewManager()
    }
    
    private func setupNavigationBar() {
        // Configure navigation bar appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Add refresh button
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshButtonTapped)
        )
        navigationItem.rightBarButtonItem = refreshButton
        
        // Add share button
        let shareButton = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareButtonTapped)
        )
        navigationItem.leftBarButtonItem = shareButton
    }
    
    private func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemBlue
        progressView.trackTintColor = .systemGray5
        progressView.isHidden = true
        
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemBlue
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupWebViewManager() {
        webViewManager = WebViewManager()
        webViewManager.delegate = self
        
        let webView = webViewManager.getWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshWebView), for: .valueChanged)
        webView.scrollView.addSubview(refreshControl)
        
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func refreshButtonTapped() {
        refreshWebView()
    }
    
    @objc private func shareButtonTapped() {
        shareCurrentPage()
    }
    
    @objc private func refreshWebView() {
        webViewManager.reload()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Private Methods
    private func loadInitialURL() {
        webViewManager.loadURL(config.initialURL)
    }
    
    private func shareCurrentPage() {
        guard let url = webViewManager.getCurrentURL() else { return }
        
        let activityViewController = UIActivityViewController(
            activityItems: [url, webViewManager.getCurrentTitle() ?? config.appName],
            applicationActivities: nil
        )
        
        // For iPad
        if let popover = activityViewController.popoverPresentationController {
            popover.barButtonItem = navigationItem.leftBarButtonItem
        }
        
        present(activityViewController, animated: true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - URL Handling
    func handleURL(_ url: URL) {
        webViewManager.loadURL(url)
    }
}

// MARK: - WebViewManagerDelegate
extension MainViewController: WebViewManagerDelegate {
    
    func webViewDidStartLoading() {
        progressView.isHidden = false
        progressView.progress = 0.0
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoading() {
        progressView.isHidden = true
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }
    
    func webViewDidFailLoading(error: Error) {
        progressView.isHidden = true
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
        
        showErrorAlert(message: error.localizedDescription)
    }
    
    func webViewDidUpdateTitle(_ title: String?) {
        if let title = title, !title.isEmpty {
            self.title = title
        }
    }
    
    func webViewShouldOpenExternalURL(_ url: URL) -> Bool {
        // Open external links in Safari
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
        return false // Don't load in WebView
    }
}
