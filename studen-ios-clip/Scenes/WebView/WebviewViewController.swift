//
//  WebviewViewController.swift
//  studen-ios-clip
//
//  Created by Andreas on 01.04.2022.
//
import UIKit
import WebKit
import StoreKit
import ApphudSDK
import AVFoundation

class WebviewViewController: UIViewController {
    
    private var webview: WKWebView?
    private var products: [ApphudProduct] = []
    private lazy var viewModel: WebviewViewModelType = WebviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebiew()
        loadUrl(API.appClip)
        bindViewModel()
        fetchProducts()
    }
    
    private func fetchProducts() {
        Apphud.paywallsDidLoadCallback { paywalls in
            guard let paywall = paywalls.first else { return }
            self.products = paywall.products
        }
    }
    
    private func configureWebiew() {
        let config = WKWebViewConfiguration()
        webview = WKWebView(frame: .zero, configuration: config)
        webview?.scrollView.bounces = false
        webview?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        webview?.uiDelegate = self
        webview?.navigationDelegate = self
        webview?.allowsBackForwardNavigationGestures = false
        view.addSubview(webview!)
    }
    
    private func loadUrl(_ url: String) {
        guard let url = URL(string: url) else { return }
        let token = UDService.shared.getToken() ?? ""
        let authCookie = HTTPCookie.cookies(withResponseHeaderFields: ["Authorization": "Bearer \(token)"], for: url)
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        authCookie.forEach {
            webview?.configuration.websiteDataStore.httpCookieStore.setCookie($0, completionHandler: nil)
        }
        webview?.load(request)
    }
    
    private func pay(by productID: String) {
        guard let product = products.first(where: { $0.productId == productID}) else { return }
        Apphud.purchase(product) { [weak self] result in
            guard let self = self else { return }
            if let subscription = result.subscription {
                self.viewModel.addSub(promoID: subscription.productId,
                                      productID: subscription.productId,
                                      isActive: subscription.isActive() ? 1 : 0,
                                      status: subscription.status.rawValue,
                                      expireDate: subscription.expiresDate,
                                      canceledAt: subscription.canceledAt,
                                      isRetryBilling: subscription.isInRetryBilling ? 1 : 0,
                                      isAutorenewEnabled: subscription.isAutorenewEnabled ? 1 : 0,
                                      isIntroductoryActivated: subscription.isIntroductoryActivated ? 1 : 0,
                                      timeStarted: subscription.startedAt)
            } else if let purchase = result.nonRenewingPurchase {
                self.viewModel.addPurchase(productID: purchase.productId)
            } else {
                self.showMessageAlert(with: result.error?.localizedDescription ?? "")
            }
        }
    }
    
    private func restore() {
        Apphud.restorePurchases { subs, nonSubs, error in
            if let error = error {
                self.showMessageAlert(with: error.localizedDescription)
            }
        }
    }
    
    private func downloadFullVersion() {
        guard
            let scene = view.window?.windowScene,
            #available(iOS 14, *)
        else { return }
        
        let config = SKOverlay.AppClipConfiguration(position: .bottom)
        let overlay = SKOverlay(configuration: config)
        overlay.delegate = self
        overlay.present(in: scene)
    }
    
}

// MARK: - Bind View Model

extension WebviewViewController {
    
    private func bindViewModel() {
        viewModel.loadState.bind { state in
            switch state {
            case .error(message: let message): self.showMessageAlert(with: message)
            case .success(message: let message): self.showMessageAlert(with: message)
            default: break
            }
        }
    }
}

// MARK: - WK UI Delegate & Navigation Delegate

extension WebviewViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        guard
            let targetString = navigationAction.request.url?.absoluteString.recognize()
        else { return }
        
        switch targetString {
        case .sub(id: _): downloadFullVersion()
        case .nonSub(id: _): downloadFullVersion()
        case .ads: downloadFullVersion()
        case .allow: openUrl(.settings)
        case .privacy: openUrl(.privacy)
        case .terms: openUrl(.terms)
        case .rateApp: openUrl(.rateApp)
        case .restore: downloadFullVersion()
        case .update: openUrl(.app)
        case .full: openUrl(.app)
        case .requestVideoPerms: AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in })
        }
    }
    
}

// MARK: - SK Overlay Delegate

extension WebviewViewController: SKOverlayDelegate {
}
