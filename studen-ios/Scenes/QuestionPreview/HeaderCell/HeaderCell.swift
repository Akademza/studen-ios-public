//
//  HeaderCell.swift
//  studen-ios
//
//  Created by Andreas on 15.03.2022.
//

import UIKit

protocol HeaderCellViewModel {
    var authorName: String { get }
    var questionText: String { get }
    var authorPhotoPath: String { get }
}

class HeaderCell: UITableViewCell {
    
    static let reuseID: String = "HeaderCell"

    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var questionText: UILabel!
    @IBOutlet private weak var authorPhoto: WebImageView!
    
    func setData(_ viewModel: HeaderCellViewModel?) {
        guard let viewModel = viewModel else { return }
        authorName.text = viewModel.authorName
        questionText.attributedText = viewModel.questionText.toAttributedString()
        authorPhoto.setPhoto(by: viewModel.authorPhotoPath)
    }
    
}
