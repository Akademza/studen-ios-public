//
//  QuestionsAssembly.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class QuestionsAssembly {
    
    func assemble(coder: NSCoder) -> QuestionsViewController? {
        let vc = QuestionsViewController(coder: coder)
        let presenter = createPresenter()
        let interactor = createInteractor()
        let router = createRouter()
        
        vc?.interactor = interactor
        vc?.router = router
        
        interactor.presenter = presenter
        presenter.viewController = vc
        router.viewController = vc
        
        return vc
    }
    
    private func createPresenter() -> QuestionsPresenter {
        return .init()
    }
    
    private func createInteractor() -> QuestionsInteractor {
        return .init()
    }
    
    private func createRouter() -> QuestionsRouter {
        return .init()
    }
    
}
