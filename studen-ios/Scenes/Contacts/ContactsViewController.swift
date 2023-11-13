//
//  ContactsViewController.swift
//  studen-ios
//
//  Created by Andreas on 15.03.2022.
//

import UIKit
import StoreKit

class ContactsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightBlue
    }
    
    @IBAction private func navigateToContacts() {
        let storyboard = UIStoryboard(name: "ContactUsVC", bundle: nil)
        guard
            let vc = storyboard.instantiateViewController(identifier: "ContactUsVC") as? ContactUsVC
        else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
//        guard
//            let scene = view.window?.windowScene,
//            #available(iOS 14.0, *)
//        else { return }
//
//        let config = SKOverlay.AppClipConfiguration(position: .bottom)
//        let overlay = SKOverlay(configuration: config)
//        overlay.delegate = self
//        overlay.present(in: scene)
    }
    
    @IBAction private func navigateToRateTheApp() {
        openUrl(.rateApp)
    }
    
    @IBAction private func navigateToAboutTheApp() {
        openUrl(.app)
    }
    
}
