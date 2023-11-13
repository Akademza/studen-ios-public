//
//  HttpErrors.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//

import Foundation

enum HttpErrors: Equatable {
    case empty
    case unknowkError
    case localizedOnServer(message: String)
    case decodeError
    case unauthorized
    case serverError
}

extension HttpErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .empty: return NSLocalizedString("Empty", comment: "")
        case .unknowkError: return NSLocalizedString("Unknown error", comment: "")
        case .localizedOnServer(message: let message): return NSLocalizedString(message, comment: "")
        case .decodeError: return NSLocalizedString("Cannot decode values", comment: "")
        case .unauthorized: return NSLocalizedString("Your session is out of date. Relogin please", comment: "")
        case .serverError: return NSLocalizedString("Server error with 500 status code", comment: "")
        }
    }
}
