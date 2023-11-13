//
//  QuestionsPresenter.swift
//  studen-ios
//
//  Created by Andreas on 01.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol QuestionsPresentationLogic {
    func presentData(response: Questions.Model.Response.ResponseType)
}

class QuestionsPresenter: QuestionsPresentationLogic {
    weak var viewController: QuestionsDisplayLogic?
    
    func presentData(response: Questions.Model.Response.ResponseType) {
        switch response {
        case .presentAuth(result: let result):
            switch result {
            case .failure(let error):
                viewController?.displayData(viewModel: .showAlert(message: error.localizedDescription))
            case .success(_):
                viewController?.displayData(viewModel: .showAlert(message: "Auth success"))
            }
        case .presentQuestions(result: let result):
            switch result {
            case .failure(let error):
                viewController?.displayData(viewModel: .showAlert(message: error.localizedDescription))
            case .success(let questionSearch):
                let cell = questionSearch.questions.map { self.questionToViewModel($0) }
                let viewModel = QuestionsViewModel(cells: cell)
                viewController?.displayData(viewModel: .displayQuestions(viewModel: viewModel))
            }
        }
    }
    
    private func questionToViewModel(_ question: Question) -> QuestionsViewModel.Cell {
        return QuestionsViewModel.Cell.init(questionText: question.snippet,
                                            answersCount: "\(question.answers_count)",
                                            questionID: question.id)
    }
    
}
