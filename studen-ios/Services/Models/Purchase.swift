//
//  Purchase.swift
//  studen-ios
//
//  Created by Andreas on 17.03.2022.
//

import Foundation

struct SubscriptionResponse: Decodable {
    let uuid: String
    let include_player_id: String
    let name: String
    let time_created: String
    let is_subscriber: Bool
    let subscription: Subscribtion
}

struct Subscribtion: Decodable {
    let product_id: String
    let promo_id: String
    let time_started: String
    let time_expired: String
    let time_show_rating: String
}

struct PurchaseResponse: Decodable {
    let uuid: String
    let include_player_id: String
    let name: String
    let time_created: String
    let points: Int
    let is_subscriber: Bool
    let answers_muted: Bool
    let version: String
    let version_check: Bool
    let use_api: Bool
}
