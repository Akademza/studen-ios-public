//
//  QuestionsRouter.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol QuestionsRoutingLogic {
    func navigateToAnswerPreview(_ id: Int)
}

class QuestionsRouter: NSObject, QuestionsRoutingLogic {
    
    
    weak var viewController: QuestionsViewController?
    
    // MARK: Routing
    
    func navigateToAnswerPreview(_ id: Int) {
        let storyboard = UIStoryboard(name: "QuestionPreviewViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "QuestionPreviewViewController", creator: { coder in
            let assembly = QuestionPreviewAssembly()
            return assembly.assemble(coder: coder)
        }) as? QuestionPreviewViewController else { return }
        vc.questionID = id
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true, completion: nil)
    }
    
}
