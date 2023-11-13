//
//  QuestionsPreviewWorker.swift
//  studen-ios
//
//  Created by Andreas on 01.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class QuestionPreviewWorker {
    
    private lazy var repo: MainRepoType = MainRepo.init()
    
    init() {
    }
    
    func fetch(id: Int?, completion: @escaping (Result<QuestionPreviewModel, Error>) -> Void) {
        guard let id = id else { return }
        repo.questionPreview(to: id, completion: completion)
    }
    
}
