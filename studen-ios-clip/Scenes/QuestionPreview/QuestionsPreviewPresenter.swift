//
//  QuestionsPreviewPresenter.swift
//  studen-ios
//
//  Created by Andreas on 01.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol QuestionPreviewPresentationLogic {
    func presentData(response: QuestionPreview.Model.Response.ResponseType)
}

class QuestionPreviewPresenter: QuestionPreviewPresentationLogic {
    weak var viewController: QuestionPreviewDisplayLogic?
    
    func presentData(response: QuestionPreview.Model.Response.ResponseType) {
        
        switch response {
        case .presentQuestionModel(result: let res):
            switch res {
            case .failure(let error):
                viewController?.displayData(viewModel: .showAlert(error: error.localizedDescription))
            case .success(let questionModel):
                let viewModel = toHeader(questionModel)
                viewController?.displayData(viewModel: .displayQuestionModel(viewModel: viewModel))
            }
        }
    }
    
    private func toHeader(_ questionModel: QuestionPreviewModel) -> QuestionPreviewViewModel {
        let cells = questionModel.answers.map({ self.answerToViewModel($0, isHidden: questionModel.answers_muted) })
        let header = QuestionPreviewViewModel.QuestionModel.init(authorName: questionModel.nick,
                                                                 questionText: questionModel.text,
                                                                 authorPhotoPath: questionModel.ava)
        let viewModel = QuestionPreviewViewModel.init(questionModel: header, answers: cells)
        return viewModel
    }
    
    private func answerToViewModel(_ answer: Answer, isHidden: Bool) -> QuestionPreviewViewModel.AnswerCell {
        return QuestionPreviewViewModel.AnswerCell.init(answerID: answer.id,
                                                        authorName: answer.nick,
                                                        isHidden: isHidden,
                                                        answerText: answer.text)
    }
    
}
