//
//  TwoCornerRoundedMask.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//

import UIKit

class TwoCornerRoundedMask: CAShapeLayer {
    
    let indexPath: IndexPath
    let cellBounds: CGRect
    let cellIndexWithCorners: Int
    
    init(indexPath: IndexPath, bounds: CGRect, cellIndexWithCorners: Int) {
        self.cellBounds = bounds
        self.indexPath = indexPath
        self.cellIndexWithCorners = cellIndexWithCorners
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let isFirstRow = indexPath.row == cellIndexWithCorners
        let isLastRow = indexPath.row == (indexPath.row - 1)
        
        var corners: UIRectCorner = []
        if isFirstRow {
            corners = corners.union([.topLeft, .topRight])
        }
        if isLastRow {
            corners = corners.union([.bottomLeft, .bottomRight])
        }
        
        // TODO: Place inside layoutSubviews method in UITableViewCell subclass
        let path = UIBezierPath(roundedRect: cellBounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: 19.0, height: 19.0))
        //        let mask = CAShapeLayer()
        
        self.path = path.cgPath
        
        //        let isFirstRow = indexPath.row == 0
        //        let isLastRow = indexPath.row == (indexPath.row - 1)
        //
        //        var corners: UIRectCorner = []
        //        if isFirstRow {
        //            corners = corners.union([.topLeft, .topRight])
        //        }
        //        if isLastRow {
        //            corners = corners.union([.bottomLeft, .bottomRight])
        //        }
        //
        //        // TODO: Place inside layoutSubviews method in UITableViewCell subclass
        //        let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 19.0, height: 19.0))
        //        let mask = CAShapeLayer()
        //        mask.path = path.cgPath
    }
    
}

