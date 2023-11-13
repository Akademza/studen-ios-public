//
//  AppDelegate.swift
//  studen-ios-clip
//
//  Created by Andreas on 01.04.2022.
//

import UIKit
import ApphudSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges) {
//    OSSubscriptionObserver
//    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Apphud.start(apiKey: API.appHudAPI)
        
//        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
//
//        OneSignal.initWithLaunchOptions(launchOptions)
//        OneSignal.setAppId("b9fc1051-e293-4ee7-9709-5a631961b084")
//
////        OneSignal.promptForPushNotifications(userResponse: { accepted in
////          print("User accepted notifications: \(accepted)")
////        })
//
//        OneSignal.add(self as OSSubscriptionObserver)
        
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

