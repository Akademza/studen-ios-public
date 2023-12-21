//
//  LoadSceneViewModel.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 22.03.2022.
//

import UIKit
import OneSignal
import ApphudSDK

protocol LoadSceneViewModelType {
    var loadState: Box<LoadSceneViewModel.LoadState> { get }
    var navigate: Box<LoadSceneViewModel.Navigate> { get }
    
    func checkAuth()
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
    
    private func checkPush(isEnabled: Bool) {
        OneSignal.promptForPushNotifications(userResponse: { [weak self] accepted in
//            let isPush = UDService.shared.isPushEnabled()
            guard isEnabled != accepted else { return }
            self?.repo.changeUserInfo(name: nil, pushNotification: accepted) { result in }
//            UDService.shared.changePushEnabled(accepted)
        })
    }
    
    func checkAuth() {
        let pushToken = OneSignal.getDeviceState().userId ?? "123"
        let userID = Apphud.userID()
        
        repo.auth(uuid: userID, playerID: pushToken, url: "", isModal: false) { result in
            switch result {
            case .failure(let error):
                self.loadState.value = .error(message: error.localizedDescription)
            case .success((let token, let user)):
                UDService.shared.setToken(token)
                self.loadState.value = .success(message: "Auth success")
                self.checkVersionAndNavigate(useApi: user.use_api,
                                             checkVersion: user.version_check,
                                             latestVersion: user.version)
                self.checkPush(isEnabled: user.notice_act)
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
        
//        navigate.value = .webview
        
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
