//
//  AnswerCell.swift
//  pifagor-ai-ios-clip
//
//  Created by Andreas on 01.04.2022.
//

import UIKit

protocol AnswerCellDelegate: AnyObject {
    func navigateToPayment()
}

protocol AnswerCellViewModel {
    var authorName: String { get }
    var isHidden: Bool { get }
    var answerText: String { get }
    var answerID: Int { get }
}

class AnswerCell: UITableViewCell {
    
    static let reuseID: String = "AnswerCell"
    
    weak var delegate: AnswerCellDelegate?
    
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var blurView: UIView!
    @IBOutlet private weak var answerText: UILabel!
    @IBOutlet private weak var seperationLine: UIView!
    
    private let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        blurView.insertSubview(blurEffect, at: 0)
        blurView.layer.cornerRadius = 15
        blurView.clipsToBounds = true
    
        blurEffect.translatesAutoresizingMaskIntoConstraints = false
        blurEffect.frame = blurView.bounds
        blurEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    func setData(_ viewModel: AnswerCellViewModel) {
        blurView.insertSubview(blurEffect, at: 0)
        authorName.text = viewModel.authorName
        blurView.isHidden = !viewModel.isHidden
        answerText.text = viewModel.answerText
        seperationLine.isHidden = viewModel.isHidden
    }
    
    @IBAction private func showAnswer() {
        delegate?.navigateToPayment()
    }
    
}

