//
//  QuestionsModels.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 01.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum Questions {
    
    enum Model {
        struct Request {
            enum RequestType {
                case search(query: String)
                case checkAuth
                case update
            }
        }
        struct Response {
            enum ResponseType {
                case presentQuestions(result: Result<QuestionSearch, Error>)
                case presentAuth(result: Result<Void, Error>)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayQuestions(viewModel: QuestionsViewModel)
                case showAlert(message: String)
            }
        }
    }
    
}

struct QuestionsViewModel {
    
    struct Cell: QuestionCellViewModel {
        var questionText: String
        var answersCount: String
        var questionID: Int
    }
    
    var cells: [Cell]
}

