//
//  LoadSceneViewController.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 22.03.2022.
//

import UIKit
import AVFoundation

class LoadSceneViewController: UIViewController {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var reloadButton: UIButton!
//    @IBOutlet private weak var authStateLabel: UILabel!
    
    private lazy var viewModel: LoadSceneViewModelType = LoadSceneViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        reloadButton.isHidden = true
        bind()
        viewModel.checkAuth()
    }
    
    @IBAction private func tryAuthAgain() {
        viewModel.checkAuth()
    }
    
    private func navigateToUpdate() {
        let storyboard = UIStoryboard(name: "UpdateViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        UIApplication.shared.windows.first?.rootViewController = vc
    }
    
}

// MARK: - Bind View Model

private extension LoadSceneViewController {
    
    private func bind() {
        viewModel.loadState.bind { [weak self] state in
            DispatchQueue.main.async {
                self?.reloadButton.isHidden = true
                self?.activityIndicator.stopAnimating()
            }
            
            switch state {
            case .notActive: break
            case .loading: self?.activityIndicator.startAnimating()
            case .success(message: _): break
            case .error(message: let message):
                DispatchQueue.main.async {
                    self?.showMessageAlert(with: message)
//                    self?.authStateLabel.text = message
                    self?.reloadButton.isHidden = false
                }
            }
        }
        
        viewModel.navigate.bind { navigate in
            switch navigate {
            case .current: break
            case .webview: UIApplication.shared.windows.first?.rootViewController = WebviewViewController()
            case .native: UIApplication.shared.windows.first?.rootViewController = Menu()
            case .update: self.navigateToUpdate()
            }
        }
    }
    
}
