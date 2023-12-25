//
//  UIViewController+Extension.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 14.03.2022.
//

import UIKit

extension UIViewController {
    
    enum WebviewUrls: String {
        case terms = "https://edu-smartsolutions.com/terms-of-use.html"
        case settings
        case privacy = "https://edu-smartsolutions.com/privacy-policy.html"
        case app = "itms-apps://apple.com/app/id6474548962"
        case rateApp = "itms-apps://apple.com/app/id6474548962?action=write-review&mt=8"
    }
    
    func openUrl(_ url: WebviewUrls) {
        var path: String
        switch url {
        case .terms: path = url.rawValue
        case .settings: path = UIApplication.openSettingsURLString
        case .privacy: path = url.rawValue
        case .app: path = url.rawValue
        case .rateApp: path = url.rawValue
        }
    
        guard
            let url = URL(string: path),
            UIApplication.shared.canOpenURL(url)
        else { return }
        UIApplication.shared.open(url)
    }
    
    func showMessageAlert(with text: String, okCompletion: @escaping () -> Void = {}) {
        let ac = UIAlertController(title: "Info", message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            okCompletion()
        }
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func showCameraNotGrantedAlert() {
        let ac = UIAlertController(title: "Grant camera access", message: "Share Pifagor AI your camera to take a task photo", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Grant", style: .cancel) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        ac.addAction(cancel)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
}
