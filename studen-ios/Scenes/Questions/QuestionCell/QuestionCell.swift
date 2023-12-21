//
//  QuestionCellTableViewCell.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 14.03.2022.
//

import UIKit

protocol QuestionCellViewModel {
    var questionText: String { get }
    var answersCount: String { get }
}

class QuestionCell: UITableViewCell {
    
    static let reuseID = "QuestionCell"

    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var answersCount: UILabel!
    @IBOutlet private weak var seperationLine: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setData(viewModel: QuestionCellViewModel, isLast: Bool) {
//        questionLabel.text = viewModel.questionText
        answersCount.text = viewModel.answersCount
        seperationLine.isHidden = isLast
        questionLabel.attributedText = viewModel.questionText.toAttributedString()
    }
    
}
