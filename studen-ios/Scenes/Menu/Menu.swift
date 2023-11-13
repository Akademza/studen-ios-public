//
//  Menu.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//

import UIKit
import ApphudSDK
import OneSignal

class Menu: UITabBarController {
    
    private lazy var repo: MainRepoType = MainRepo.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createQeustionsScene(),
            createContactsScene()
        ]
        
        tabBar.tintColor = .lightBlue
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        
    }
    
    private func createQeustionsScene() -> QuestionsViewController {
        let storyboard = UIStoryboard(name: "QuestionsViewController", bundle: nil)
        guard
            let vc = storyboard.instantiateViewController(identifier: "QuestionsViewController", creator: { coder in
                let assembly = QuestionsAssembly()
                return assembly.assemble(coder: coder)
            }) as? QuestionsViewController
        else { return QuestionsViewController() }
        let item = UITabBarItem(title: "", image: #imageLiteral(resourceName: "search"), tag: 0)
        vc.tabBarItem = item
        return vc
    }
    
    private func createContactsScene() -> ContactsViewController {
        let storyboard = UIStoryboard(name: "ContactsViewController", bundle: nil)
        guard
            let vc = storyboard.instantiateViewController(identifier: "ContactsViewController") as? ContactsViewController
        else { return ContactsViewController() }
        let item = UITabBarItem(title: "", image: #imageLiteral(resourceName: "contacts"), tag: 1)
        vc.tabBarItem = item
        return vc
    }
    
    private func checkAuth() {
////        UDService.shared.clearData()
//
//        let pushToken = OneSignal.getDeviceState().pushToken ?? "123"
////        let token = UDService.shared.getToken()
////        guard token == nil || token == "" else { return }
//        // showMessageAlert(with: "AuthSuccess")
//
//        guard let deviceToken = UIDevice.current.identifierForVendor?.uuidString else { return }
//        repo.auth(uuid: deviceToken, playerID: pushToken) { result in
//            switch result {
//            case .failure(let error):
//                self.showMessageAlert(with: error.localizedDescription)
//            case .success((let token, let useApi)):
//                if !useApi {
//                    UIApplication.shared.windows.first?.rootViewController = WebviewViewController()
//                }
//                UDService.shared.setToken(token)
//                self.showMessageAlert(with: "Auth success")
//            }
//        }
    }
    
}
