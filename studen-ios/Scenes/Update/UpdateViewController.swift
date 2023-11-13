//
//  UpdateViewController.swift
//  studen-ios
//
//  Created by Andreas on 24.03.2022.
//

import UIKit

class UpdateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func navigateToUpdate() {
        guard
            let url = URL(string: "itms-apps://apple.com/app/id1608580002"),
            UIApplication.shared.canOpenURL(url)
        else { return }
        UIApplication.shared.open(url)
    }
    
}
