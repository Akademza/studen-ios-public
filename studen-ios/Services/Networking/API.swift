//
//  API.swift
//  pifagor-ai-ios
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
    //static let host = "app-release.pifagor.ai"
    static let host = "app.pifagor.ai"
    static let os = "iOS"
    static let apiKey = "DjGGXefNwEE6jq6JzaXLpJkKfgb5K8KP"
    //static let mainWebsite = "https://webview-release.pifagor.ai/"
    static let mainWebsite = "https://webview.pifagor.ai/"
    static let appHudAPI = "app_kaQZMcgL66hVDfg7J3sxxHPSTUFz2c"
    static let pushAPIKey = "b9fc1051-e293-4ee7-9709-5a631961b084"
    //static let appClip = "https://webview-release.pifagor.ai/mini"
    static let appClip = "https://webview.pifagor.ai/mini"
}
