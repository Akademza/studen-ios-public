//
//  API.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//

import Foundation

struct API {
    
    struct Enpoints {
        static let auth = "/api/user"
        static let search = "/api/search"
        static let questionPreview = "/api/questions/"
        
        static let buySubscription = "/api/user/subscription"
        static let buyNonSub = "/api/user/points"
        static let sendApphudInfo = "/api/apphud"
        
    }
    
    static let version = "1.0.3"
    static let scheme = "https"
    static let host = "app.studen.com"
    static let os = "iOS"
    static let apiKey = "DjGGXefNwEE6jq6JzaXLpJkKfgb5K8KP"
    static let mainWebsite = "https://webview.studen.com/"
    static let appHudAPI = "app_kaQZMcgL66hVDfg7J3sxxHPSTUFz2c"
    static let pushAPIKey = "b9fc1051-e293-4ee7-9709-5a631961b084"
    static let appClip = "https://webview-release.studen.com/mini"
}
