//
//  SearchCell.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//

import UIKit

protocol SearchCellDelegate: AnyObject {
    func searchQuery(with text: String)
}

class SearchCell: UITableViewCell {
    
    static let reuseID = "SearchCell"
    
    weak var delegate: SearchCellDelegate?
    
    @IBOutlet private weak var searchField: UITextField!
    private var isSearchBarListeningStart = false
    private var lastTextPasted = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        searchField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        searchField.delegate = self
    }
    
    @objc private func fieldChanged() {
        isSearchBarListeningStart = true
        lastTextPasted = searchField.text ?? ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            if self.isSearchBarListeningStart {
                self.delegate?.searchQuery(with: self.lastTextPasted)
                self.isSearchBarListeningStart = false
            }
        }
    }
    
    func resignSearchField() {
        searchField.becomeFirstResponder()
    }
    
}

extension SearchCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchQuery(with: textField.text ?? "")
        return true
    }
    
}
