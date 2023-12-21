//
//  Menu.swift
//  pifagor-ai-ios-clip
//
//  Created by Andreas on 01.04.2022.
//

import UIKit
//import ApphudSDK

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
    
}

