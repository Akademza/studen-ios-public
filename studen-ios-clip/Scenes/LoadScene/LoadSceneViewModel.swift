//
//  LoadSceneViewModel.swift
//  pifagor-ai-ios-clip
//
//  Created by Andreas on 01.04.2022.
//

import UIKit
//import OneSignal
import ApphudSDK

protocol LoadSceneViewModelType {
    var loadState: Box<LoadSceneViewModel.LoadState> { get }
    var navigate: Box<LoadSceneViewModel.Navigate> { get }
    
    func checkAuth(url: String, isModal: Bool)
}

class LoadSceneViewModel: LoadSceneViewModelType {
    
    enum LoadState {
        case notActive
        case loading
        case success(message: String)
        case error(message: String)
    }
    
    enum Navigate {
        case current
        case webview
        case native
        case update
    }
    
    var loadState: Box<LoadState> = .init(.loading)
    var navigate: Box<Navigate> = .init(.current)
    
    private lazy var repo: MainRepoType = MainRepo.init()
    
    func checkAuth(url: String, isModal: Bool) {
//        let pushToken = OneSignal.getDeviceState().userId ?? "123"
        let userID = Apphud.userID()
        
        repo.auth(uuid: userID, playerID: "pushToken", url: url, isModal: isModal) { result in
            switch result {
            case .failure(let error):
                self.loadState.value = .error(message: error.localizedDescription)
            case .success((let token, let user)):
                UDService.shared.setToken(token)
                self.loadState.value = .success(message: "Auth success")
                self.checkVersionAndNavigate(useApi: user.use_api,
                                             checkVersion: user.version_check,
                                             latestVersion: user.version)
            }
        }
    }
    
    private func checkVersionAndNavigate(useApi: Bool, checkVersion: Bool, latestVersion: String) {
        guard
            let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        else {
            loadState.value = .error(message: "Try again")
            return
        }
        
//        navigate.value = .native
        
        if !checkVersion && currentAppVersion != latestVersion {
            navigate.value = .native
        } else if !checkVersion && currentAppVersion == latestVersion {
            navigate.value = .webview
        } else if checkVersion && currentAppVersion != latestVersion {
            navigate.value = .update
        } else if checkVersion && currentAppVersion == latestVersion {
            navigate.value = .webview
        } else {
            navigate.value = .current
            loadState.value = .error(message: "Try again")
        }
    }
    
}
