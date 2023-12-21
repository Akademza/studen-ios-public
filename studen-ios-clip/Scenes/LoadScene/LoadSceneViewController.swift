//
//  LoadSceneViewController.swift
//  pifagor-ai-ios-clip
//
//  Created by Andreas on 01.04.2022.
//

import UIKit

class LoadSceneViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let reloadButton = UIButton()
    private let logoImage = UIImageView()
    private let url: String
    private let isModal: Bool
    
    private lazy var viewModel: LoadSceneViewModelType = LoadSceneViewModel()
    
    init(url: String, isModal: Bool) {
        self.url = url
        self.isModal = isModal
        
        super.init(nibName: nil, bundle: nil)

        bind()
        viewModel.checkAuth(url: url, isModal: isModal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UI()
        setConstraints()
    }
    
    private func UI() {
        view.backgroundColor = .white
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightBlue
        activityIndicator.tintColor = .white
        reloadButton.isHidden = true
        
        logoImage.image = UIImage(named: "logo")
        logoImage.layer.cornerRadius = 7
        logoImage.clipsToBounds = true
        logoImage.contentMode = .scaleAspectFit
        
        reloadButton.backgroundColor = .lightBlue
        reloadButton.setTitle("Try again", for: .normal)
        reloadButton.tintColor = .white
        reloadButton.setTitleColor(.white, for: .normal)
        reloadButton.layer.cornerRadius = 25
        reloadButton.addTarget(self, action: #selector(tryAuthAgain), for: .touchUpInside)
    }
    
    private func setConstraints() {
        let stack = UIStackView(arrangedSubviews: [logoImage, activityIndicator])
        stack.spacing = 20
        stack.axis =  .vertical
        stack.alignment = .center
        stack.distribution = .fill
        
        view.addSubview(stack)
        view.addSubview(reloadButton)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
    
        
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 162),
            logoImage.widthAnchor.constraint(equalToConstant: 162)
        ])
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            reloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            reloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            reloadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            reloadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func tryAuthAgain() {
        viewModel.checkAuth(url: url, isModal: isModal)
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

