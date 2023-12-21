//
//  Date+Extension.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 17.03.2022.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: self)
    }
}
