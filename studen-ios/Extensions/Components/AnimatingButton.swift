//
//  UIButton+Extension.swift
//  studen-ios
//
//  Created by Andreas on 17.03.2022.
//

import UIKit

class AnimatingButton: UIButton {
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureActivity()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureActivity()
        constraints()
    }
    
    private func configureActivity() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
        isEnabled = false
        alpha = 0.8
        setTitleColor(.clear, for: .normal)
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        isEnabled = true
        alpha = 1.0
        setTitleColor(.white, for: .normal)
    }
}
