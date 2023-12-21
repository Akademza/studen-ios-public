//
//  QuestionsPreviewAssembly.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 01.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class QuestionPreviewAssembly {
    
    func assemble(coder: NSCoder) -> QuestionPreviewViewController? {
        let vc = QuestionPreviewViewController(coder: coder)
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
    
    private func createPresenter() -> QuestionPreviewPresenter {
        return .init()
    }
    
    private func createInteractor() -> QuestionPreviewInteractor {
        return .init()
    }
    
    private func createRouter() -> QuestionPreviewRouter {
        return .init()
    }
    
}
