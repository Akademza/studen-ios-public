//
//  User.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 16.03.2022.
//

import Foundation

struct User: Decodable {
    let uuid: String
    let include_player_id: String
    let name: String
    let time_created: String
    let notice_act: Bool
    let points: Int
    let url: String
    let modal: String
    let is_subscriber: Bool
    let badgeCount: Int?
    let hasBadge: Bool?
    let is_new: Bool?
    let answers_muted: Bool
    let version: String
    let version_check: Bool
    let use_api: Bool
}
