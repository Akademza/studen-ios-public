//
//  PaymentViewController.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 15.03.2022.
//

import UIKit
import ApphudSDK

class PaymentViewController: UIViewController {
    
    private var products: [ApphudProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Apphud.paywallsDidLoadCallback { paywalls in
            guard let paywall = paywalls.first else { return }
            self.products = paywall.products
        }
    }
    
    @IBAction private func pay(_ sender: AnimatingButton) {
        
        var productID: String = ""
        switch sender.tag {
        case 0: productID = "podpiska099"
        case 1: productID = "podpiska199"
        case 2: productID = "podpiska499"
        case 3: productID = "podpiska1499"
        case 4: productID = "pay1"
        case 5: productID = "pay5"
        default: break
        }
        
        guard
            let product = products.first(where: { $0.productId == productID})
        else { return }
        
        sender.startAnimating()
        Apphud.purchase(product) { [weak self] result in
            guard let self = self else { return }
            if let subscription = result.subscription, subscription.isActive(){
                self.showMessageAlert(with: "Success")
                self.dismiss(animated: true, completion: nil)
            } else if let purchase = result.nonRenewingPurchase, purchase.isActive(){
                self.showMessageAlert(with: "Success")
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showMessageAlert(with: result.error?.localizedDescription ?? "")
            }
            sender.stopAnimating()
        }
    }
    
    @IBAction private func dismissScene() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func restorePurchases() {
        Apphud.restorePurchases { subs, nonSubs, error in
            if let error = error {
                self.showMessageAlert(with: error.localizedDescription)
            }
        }
    }
}
