//
//  QuestionsPreviewModels.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 01.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation

enum QuestionPreview {
    
    enum Model {
        struct Request {
            enum RequestType {
                case fetchModel(id: Int?)
            }
        }
        struct Response {
            enum ResponseType {
                case presentQuestionModel(result: Result<QuestionPreviewModel, Error>)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayQuestionModel(viewModel: QuestionPreviewViewModel)
                case showAlert(error: String)
            }
        }
    }
    
}

struct QuestionPreviewViewModel {
    
    struct AnswerCell: AnswerCellViewModel {
        var answerID: Int
        var authorName: String
        var isHidden: Bool
        var answerText: String
    }
    
    struct QuestionModel: HeaderCellViewModel {
        var authorName: String
        var questionText: String
        var authorPhotoPath: String
    }
    
    let questionModel: QuestionModel?
    let answers: [AnswerCell]
}
