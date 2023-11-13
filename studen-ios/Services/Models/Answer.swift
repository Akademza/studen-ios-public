//
//  Answer.swift
//  studen-ios
//
//  Created by Andreas on 16.03.2022.
//

import Foundation

struct Answer: Decodable {
    let id: Int
    let nick: String
    let ava: String
    let text: String
    let votes_count: Int
    let useless_count: Int
    let voted: Bool
    let useless: Bool
}
