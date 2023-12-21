//
//  QuestionsPreviewRouter.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 01.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol QuestionPreviewRoutingLogic {
    func navigateToPayment()
}

class QuestionPreviewRouter: NSObject, QuestionPreviewRoutingLogic {
    
    
    weak var viewController: QuestionPreviewViewController?
    
    // MARK: Routing
    
    func navigateToPayment() {
//        let storyboard = UIStoryboard(name: "PaymentViewController", bundle: nil)
//        guard
//            let vc = storyboard.instantiateViewController(identifier: "PaymentViewController") as? PaymentViewController
//        else { return }
//        vc.modalPresentationStyle = .fullScreen
//        viewController?.present(vc, animated: true, completion: nil)
    }
    
}
