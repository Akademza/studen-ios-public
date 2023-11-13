//
//  TransparentTableView.swift
//  studen-ios
//
//  Created by Andreas on 15.03.2022.
//

import UIKit

class TransparentTableView: UITableView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if point.y > 0 {
            return true
        } else {
            return false
        }
    }
    
}

