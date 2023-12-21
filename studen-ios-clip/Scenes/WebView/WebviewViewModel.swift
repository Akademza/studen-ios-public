//
//  WebviewViewModel.swift
//  pifagor-ai-ios-clip
//
//  Created by Andreas on 01.04.2022.
//

import Foundation

protocol WebviewViewModelType {
    var loadState: Box<WebviewViewModel.LoadState> { get }
    
    func addSub(promoID: String, productID: String, isActive: Int, status: Int, expireDate: Date, canceledAt: Date?, isRetryBilling: Int, isAutorenewEnabled: Int, isIntroductoryActivated: Int, timeStarted: Date)
    func addPurchase(productID: String)
}

class WebviewViewModel: WebviewViewModelType {
    
    enum LoadState {
        case notActive
        case loading
        case success(message: String)
        case error(message: String)
    }
    
    var loadState: Box<LoadState> = .init(.notActive)
    
    private lazy var repo: MainRepoType = MainRepo.init()
    
    func addSub(promoID: String, productID: String, isActive: Int, status: Int, expireDate: Date, canceledAt: Date?, isRetryBilling: Int, isAutorenewEnabled: Int, isIntroductoryActivated: Int, timeStarted: Date) {
        repo.addSub(promoID: promoID, productID: productID, isActive: isActive, status: status, expireDate: expireDate, canceledAt: canceledAt, isRetryBilling: isRetryBilling, isAutorenewEnabled: isAutorenewEnabled, isIntroductoryActivated: isIntroductoryActivated, timeStarted: timeStarted) { result in
            switch result {
            case .failure(let error):
                self.loadState.value = .error(message: error.localizedDescription)
            case .success(let response):
                if response.is_subscriber {
                    self.loadState.value = .success(message: "Subscription is active")
                } else {
                    self.loadState.value = .success(message: "Can`t activate subscription")
                }
            }
        }
    }
    
    func addPurchase(productID: String) {
        repo.addPurchase(productID: productID) { result in
            switch result {
            case .failure(let error):
                self.loadState.value = .error(message: error.localizedDescription)
            case .success(let response):
                if response.is_subscriber {
                    self.loadState.value = .success(message: "Purchase is success")
                } else {
                    self.loadState.value = .success(message: "Can`t buy this item")
                }
            }
        }
    }
    
}

