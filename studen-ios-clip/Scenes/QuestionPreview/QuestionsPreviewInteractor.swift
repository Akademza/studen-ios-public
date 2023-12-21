//
//  QuestionsPreviewInteractor.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 01.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol QuestionPreviewBusinessLogic {
    func makeRequest(request: QuestionPreview.Model.Request.RequestType)
}

class QuestionPreviewInteractor: QuestionPreviewBusinessLogic {
    
    var presenter: QuestionPreviewPresentationLogic?
    var service: QuestionPreviewWorker?
    
    func makeRequest(request: QuestionPreview.Model.Request.RequestType) {
        if service == nil {
            service = QuestionPreviewWorker()
        }
        
        switch request {
        case .fetchModel(id: let id):
            service?.fetch(id: id, completion: { [weak self] result in
                guard let self = self else { return }
                self.presenter?.presentData(response: .presentQuestionModel(result: result))
            })
        }
    }
    
}

