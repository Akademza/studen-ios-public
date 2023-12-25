//
//  String+Extension.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 17.03.2022.
//

import UIKit

extension String {
    
    func recognize() -> WebviewCommands? {
        if self.contains("ads") {
            return .ads
        } else if self.contains("allow") {
            return .allow
        } else if self.contains("privacy") {
            return .privacy
        } else if self.contains("terms") {
            return .terms
        } else if self.contains("rate-app") {
            return .rateApp
        } else if self.contains("restore") {
            return .restore
        } else if self.contains("update") {
            return .update
        } else if self.contains("about") {
            return .full
        } else if self.contains("pay1") {
            return .nonSub(id: "pay1")
        } else if self.contains("podpiska099") {
            return .sub(id: "podpiska099")
        } else if self.contains("podpiska199") {
            return .sub(id: "podpiska199")
        } else if self.contains("podpiska499") {
            return .sub(id: "podpiska499")
        } else if self.contains("pay5") {
            return .nonSub(id: "pay5")
        } else if self.contains("podpiska1499") {
            return .sub(id: "podpiska1499")
        } else if self.contains("allow-camera") {
            return .requestVideoPerms
        } else {
            return nil
        }
    }
    
    func toAttributedString() -> NSMutableAttributedString? {
        let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        //let attributes:[NSAttributedString.Key:NSObject] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        let result = try? NSMutableAttributedString(data: htmlData ?? Data(), options: options, documentAttributes: nil)
        result?.convertFontTo(font: UIFont.systemFont(ofSize: 20))
        return result

    }
    
    func removeAddHash() -> String {
        let res = self.split(separator: "#")
        return String(res.first ?? "")
    }
    
    func removeAnyHash() -> String {
        let res = self.split(separator: "#")
        return String(res.first ?? "")
    }
    
    func getPromoID() -> String {
        if self.contains("promo") {
            let res = split(separator: "_")
            return String(res.last ?? "")
        } else {
            return ""
        }
    }
    
}

enum WebviewCommands {
    case sub(id: String)
    case nonSub(id: String)
    case ads
    case allow
    case privacy
    case terms
    case rateApp
    case restore
    case update
    case full
    case requestVideoPerms
}

extension NSMutableAttributedString
{
    func convertFontTo(font: UIFont)
    {
        var range = NSMakeRange(0, 0)

        while (NSMaxRange(range) < length) {
            let attributes = attributes(at: NSMaxRange(range), effectiveRange: &range)
            if let oldFont = attributes[NSAttributedString.Key.font]
            {
                let newFont = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits((oldFont as AnyObject).fontDescriptor.symbolicTraits)!, size: font.pointSize)
                addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
            }
        }
    }
}
