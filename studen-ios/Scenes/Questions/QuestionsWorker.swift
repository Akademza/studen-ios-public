//
//  QuestionsWorker.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 14.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class QuestionsWorker {
    
    private lazy var repo: MainRepoType = MainRepo.init()
    private var lastQuery: String = ""
    
    init() {
    }
    
    func checkAuth(completion: @escaping (Result<Void, Error>) -> Void) {
        guard UDService.shared.getToken() == nil
        else {
            completion(.success(Void()))
            return
        }
        
        guard let deviceToken = UIDevice.current.identifierForVendor?.uuidString else { return }
        repo.auth(uuid: deviceToken, playerID: "123", url: "", isModal: false) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success((let token, let useApi)):
                UDService.shared.setToken(token)
                completion(.success(Void()))
            }
        }
    }
    
    func updateQeury(completion: @escaping (Result<QuestionSearch, Error>) -> Void) {
        repo.searchQuestions(by: lastQuery, completion: completion)
    }
    
    func search(by query: String, completion: @escaping (Result<QuestionSearch, Error>) -> Void) {
        lastQuery = query
        repo.searchQuestions(by: query, completion: completion)
    }
    
}
