//
//  AppDelegate.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 14.03.2022.
//

import UIKit
import ApphudSDK
import OneSignal
import Appodeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate, OSSubscriptionObserver {
    
    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges) {
//        if !stateChanges.from.subscribed && stateChanges.to.subscribed {
//           print("Subscribed for OneSignal push notifications!")
//        }
//        print("SubscriptionStateChange: \n\(stateChanges)")
//
//        //The player id is inside stateChanges. But be careful, this value can be nil if the user has not granted you permission to send notifications.
//        if let playerId = stateChanges.to.userId {
//           print("Current playerId \(playerId)")
//        }
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Apphud.start(apiKey: API.appHudAPI)
        
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("b9fc1051-e293-4ee7-9709-5a631961b084")
        
        OneSignal.add(self as OSSubscriptionObserver)
        
        Appodeal.initialize(withApiKey: "7cf448c2e22c46d115ac90adea331c4f0034910c5a958eab", types: .rewardedVideo)
        
        
        return true
    }
    


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

