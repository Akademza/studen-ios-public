//
//  WebviewViewController.swift
//  studen-ios
//
//  Created by Andreas on 15.03.2022.
//

import UIKit
import WebKit
import ApphudSDK
import Appodeal
import AVFoundation

class WebviewViewController: UIViewController {
    
    private var webview: WKWebView?
    private var products: [ApphudProduct] = []
    private lazy var viewModel: WebviewViewModelType = WebviewViewModel()
    private var isPaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebiew()
        loadUrl(API.mainWebsite)
        fetchProducts()
        bindViewModel()
        Appodeal.setRewardedVideoDelegate(self)
        Apphud.setDelegate(self)
    }
    
    private func testApphudRestore() {
        self.viewModel.sendAppHudInfo(productID: "podpiska099",
                                      isActive: 1,
                                      status: 1,
                                      expireDate: Date.distantFuture,
                                      canceledAt: Date.distantFuture,
                                      isRetryBilling: 1,
                                      isAutorenewEnabled: 1,
                                      isIntroductoryActivated: 1)
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
        
        guard let webview = webview else { return }
        
        webview.scrollView.bounces = false
        webview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        webview.allowsBackForwardNavigationGestures = false
        view.addSubview(webview)
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
    
    private func pay(by productID: String, promoID: String) {
//        testPay(by: productID, promoID: promoID)
//        return
        
        guard
            let product = products.first(where: { $0.productId == productID}),
            let currentUrlString = webview?.url?.absoluteString
        else { return }
        
        isPaying = true
        
        Apphud.purchase(product) { [weak self] result in
            guard
                let self = self,
                result.error == nil
            else { return }
            
            if let subscription = result.subscription {
                self.viewModel.addSub(promoID: promoID,
                                      productID: subscription.productId,
                                      isActive: subscription.isActive() ? 1 : 0,
                                      status: subscription.status.rawValue,
                                      expireDate: subscription.expiresDate,
                                      canceledAt: subscription.canceledAt,
                                      isRetryBilling: subscription.isInRetryBilling ? 1 : 0,
                                      isAutorenewEnabled: subscription.isAutorenewEnabled ? 1 : 0,
                                      isIntroductoryActivated: subscription.isIntroductoryActivated ? 1 : 0,
                                      timeStarted: subscription.startedAt)
                let res = currentUrlString.removeAnyHash()

                let urlWithoutHash = res + "#otvet"
                self.loadUrl(urlWithoutHash)
            } else if let purchase = result.nonRenewingPurchase {
                self.viewModel.addPurchase(productID: purchase.productId)
            } else {
                self.showMessageAlert(with: result.error?.localizedDescription ?? "")
            }
            
            self.isPaying = false
        } // apphud
    }
    
    private func testPay(by productID: String, promoID: String) {
        let currentUrlString1 = webview!.url!.absoluteString
        
        self.viewModel.addSub(promoID: promoID,
                              productID: productID,
                              isActive: 1,
                              status: 1,
                              expireDate: .distantFuture,
                              canceledAt: .distantFuture,
                              isRetryBilling: 1,
                              isAutorenewEnabled: 1,
                              isIntroductoryActivated: 1,
                              timeStarted: Date.init())
        let res = currentUrlString1.removeAnyHash()
        
        let urlWithoutHash = res + "#otvet"
        self.loadUrl(urlWithoutHash)
    }
    
    private func restore() {
        Apphud.restorePurchases { [weak self] subs, nonSubs, error in
            guard let self = self else { return }
            if let error = error {
                self.showMessageAlert(with: error.localizedDescription)
            }
            
            if let subscription = subs?.first(where: { $0.isActive() == true }) {
                self.viewModel.sendAppHudInfo(productID: subscription.productId,
                                              isActive: subscription.isActive() ? 1 : 0,
                                              status: subscription.status.rawValue,
                                              expireDate: subscription.expiresDate,
                                              canceledAt: subscription.canceledAt,
                                              isRetryBilling: subscription.isInRetryBilling ? 1 : 0,
                                              isAutorenewEnabled: subscription.isAutorenewEnabled ? 1 : 0,
                                              isIntroductoryActivated: subscription.isIntroductoryActivated ? 1 : 0)
                
                guard let res = self.webview?.url?.absoluteString.removeAnyHash() else { return }
                let urlWithoutHash = res + "#otvet"
                self.loadUrl(urlWithoutHash)
            }
        }
    }
    
    private func showAdd() {
        guard Appodeal.isReadyForShow(with: .rewardedVideo)
        else {
            showMessageAlert(with: "Can`t show add. Try again later")
            return
        }
        DispatchQueue.main.async {
            Appodeal.showAd(.rewardedVideo, rootViewController: self)
        }
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
            let targetString = navigationAction.request.url?.absoluteString,
            let switchType = targetString.recognize()
        else { return }
        
        let promoID = targetString.getPromoID()
        
        switch switchType {
        case .sub(id: let id): pay(by: id, promoID: promoID)
        case .nonSub(id: let id): pay(by: id, promoID: promoID)
        case .ads: showAdd()
        case .allow: openUrl(.settings)
        case .privacy: openUrl(.privacy)
        case .terms: openUrl(.terms)
        case .rateApp: openUrl(.rateApp)
        case .restore: restore()
        case .update: openUrl(.app)
        case .full: openUrl(.app)
        case .requestVideoPerms: AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in })
        }
    }
    
}

// MARK: - Appodeal Rewarded Video Delegate

extension WebviewViewController: AppodealRewardedVideoDelegate {
    
    func rewardedVideoWillDismissAndWasFullyWatched(_ wasFullyWatched: Bool) {
        guard let currentUrlString = webview?.url?.absoluteString else { return }
        let res = currentUrlString.removeAddHash()
        let urlWithHash = res + "#otvet"
        loadUrl(urlWithHash)
    }
    
}

// MARK: - Apphud Delegate

extension WebviewViewController: ApphudDelegate {
    
    func apphudSubscriptionsUpdated(_ subscriptions: [ApphudSubscription]) {
        guard
            let sub = subscriptions.first,
            !isPaying
        else { return }
        viewModel.sendAppHudInfo(productID: sub.productId,
                                 isActive: sub.isActive() ? 1 : 0,
                                 status: sub.status.rawValue,
                                 expireDate: sub.expiresDate,
                                 canceledAt: sub.canceledAt,
                                 isRetryBilling: sub.isInRetryBilling ? 1 : 0,
                                 isAutorenewEnabled: sub.isAutorenewEnabled ? 1 : 0 ,
                                 isIntroductoryActivated: sub.isIntroductoryActivated ? 1 : 0)
    }
    
}
