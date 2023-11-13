//
//  Question.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//

import Foundation

// MARK: - Question Search
struct QuestionSearch: Decodable {
    let total: Int
    let questions: [Question]
}

struct Question: Decodable {
    let id: Int
    let answers_count: Int
    let snippet: String
}

// MARK: - Question Preview
struct QuestionPreviewModel: Decodable {
    let ads: Bool
    let id: Int
    let nick: String
    let ava: String
    let text: String
    let answers_count: Int
    let answers_muted: Bool
    let answers: [Answer]
    
}
