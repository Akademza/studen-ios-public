//
//  QuestionsInteractor.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol QuestionsBusinessLogic {
    func makeRequest(request: Questions.Model.Request.RequestType)
}

class QuestionsInteractor: QuestionsBusinessLogic {
    
    var presenter: QuestionsPresentationLogic?
    var service: QuestionsWorker?
    
    func makeRequest(request: Questions.Model.Request.RequestType) {
        if service == nil {
            service = QuestionsWorker()
        }
        
        switch request {
        case .checkAuth:
            service?.checkAuth(completion: { [weak self] result in
                guard let self = self else { return }
                self.presenter?.presentData(response: .presentAuth(result: result))
            })
        case .search(query: let query):
            service?.search(by: query, completion: { [weak self] result in
                guard let self = self else { return }
                self.presenter?.presentData(response: .presentQuestions(result: result))
            })
        case .update:
            service?.updateQeury(completion: { [weak self] result in
                guard let self = self else { return }
                self.presenter?.presentData(response: .presentQuestions(result: result))
            })
        }
        
        
    }
    
}
