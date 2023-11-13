//
//  MainRepo.swift
//  studen-ios
//
//  Created by Andreas on 14.03.2022.
//

import Foundation

protocol MainRepoType: AnyObject {
    func auth(uuid: String, playerID: String, url: String, isModal: Bool, completion: @escaping (Result<(token: String, user: User), Error>) -> Void)
    func searchQuestions(by query: String, completion: @escaping (Result<QuestionSearch, Error>) -> Void)
    func questionPreview(to id: Int, completion: @escaping (Result<QuestionPreviewModel, Error>) -> Void)
    func addSub(promoID: String, productID: String, isActive: Int, status: Int, expireDate: Date, canceledAt: Date?, isRetryBilling: Int, isAutorenewEnabled: Int, isIntroductoryActivated: Int, timeStarted: Date, completiong: @escaping (Result<SubscriptionResponse, Error>) -> Void)
    func addPurchase(productID: String, completion: @escaping (Result<PurchaseResponse, Error>) -> Void)
    func changeUserInfo(name: String?, pushNotification: Bool, completion: @escaping (Result<Void, Error>) -> Void)
    func sendAppHudInfo(productID: String, isActive: Int, status: Int, expireDate: Date, canceledAt: Date?, isRetryBilling: Int, isAutorenewEnabled: Int, isIntroductoryActivated: Int, completiong: @escaping (Result<HttpError, Error>) -> Void)
}

class MainRepo {
    
    private let networking: Networking
    
    init(networking: Networking = NetworkService.init()) {
        self.networking = networking
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(type.self, from: from!)
            return response
        } catch {
            print(error)
            return nil
        }
    }
}

// MARK: - Main Repo Type

extension MainRepo: MainRepoType {
    
    func sendAppHudInfo(productID: String, isActive: Int, status: Int, expireDate: Date, canceledAt: Date?, isRetryBilling: Int, isAutorenewEnabled: Int, isIntroductoryActivated: Int, completiong: @escaping (Result<HttpError, Error>) -> Void) {
        let fullString = "productId=\(productID)&isActive=\(isActive)&status=\(status)&expiresDate=\(expireDate.toString())&canceledAt=\(canceledAt?.toString() ?? "")&isInRetryBilling=\(isRetryBilling)&isAutorenewEnabled=\(isAutorenewEnabled)&isIntroductoryActivated=\(isIntroductoryActivated)"
        guard let data = fullString.data(using: .utf8) else { return }
        
        networking.postRequestUrlEncoded(path: API.Enpoints.sendApphudInfo, body: data) { data, error, statusCode, headers in
            if let error = error {
                completiong(.failure(error))
                return
            }
            
            switch statusCode {
            case 201:
                guard let res = self.decodeJSON(type: HttpError.self, from: data) else {
                    completiong(.failure(HttpErrors.decodeError))
                    return
                }
                completiong(.success(res))
            case 500: completiong(.failure(HttpErrors.serverError))
            case 401: completiong(.failure(HttpErrors.unauthorized))
            case 400:
                guard let res = self.decodeJSON(type: HttpError.self, from: data) else {
                    completiong(.failure(HttpErrors.decodeError))
                    return
                }
                completiong(.failure(HttpErrors.localizedOnServer(message: res.message)))
            default: completiong(.failure(HttpErrors.unknowkError))
            }
        }
    }
    
    
    func changeUserInfo(name: String?, pushNotification: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let paramString = "notice_act=\(pushNotification)&name=\(name ?? "")"
        guard let data = paramString.data(using: .utf8) else { return }
        
        networking.putRequestUrlEncoded(path: API.Enpoints.auth, body: data) { data, error, statusCode, headers in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            switch statusCode {
            case 200:
                guard let _ = self.decodeJSON(type: User.self, from: data)
                else {
                    completion(.failure(HttpErrors.decodeError))
                    return
                }
            
                completion(.success(Void()))
            case 400:
                guard
                    let error = self.decodeJSON(type: HttpError.self, from: data)?.message
                else {
                    completion(.failure(HttpErrors.unknowkError))
                    return
                }
                completion(.failure(HttpErrors.localizedOnServer(message: error)))
            case 401: completion(.failure(HttpErrors.unauthorized))
            default: completion(.failure(HttpErrors.unknowkError))
            }
        }
    }
    
    func addSub(promoID: String, productID: String, isActive: Int, status: Int, expireDate: Date, canceledAt: Date?, isRetryBilling: Int, isAutorenewEnabled: Int, isIntroductoryActivated: Int, timeStarted: Date, completiong: @escaping (Result<SubscriptionResponse, Error>) -> Void) {
        let fullString = "promo_id=\(promoID)&productId=\(productID)&isActive=\(isActive)&status=\(status)&expiresDate=\(expireDate.toString())&canceledAt=\(canceledAt?.toString() ?? "")&isInRetryBilling=\(isRetryBilling)&isAutorenewEnabled=\(isAutorenewEnabled)&isIntroductoryActivated=\(isIntroductoryActivated)&time_started=\(timeStarted.toString())"
        guard let data = fullString.data(using: .utf8) else { return }
        
        networking.postRequestUrlEncoded(path: API.Enpoints.buySubscription, body: data) { data, error, statusCode, headers in
            if let error = error {
                completiong(.failure(error))
                return
            }
            
            switch statusCode {
            case 201:
                guard let res = self.decodeJSON(type: SubscriptionResponse.self, from: data) else {
                    completiong(.failure(HttpErrors.decodeError))
                    return
                }
                completiong(.success(res))
            case 500: completiong(.failure(HttpErrors.unknowkError))
            case 401: completiong(.failure(HttpErrors.unauthorized))
            default: completiong(.failure(HttpErrors.unknowkError))
            }
        }
    }
    
    func addPurchase(productID: String, completion: @escaping (Result<PurchaseResponse, Error>) -> Void) {
        let fullString = "promo_id=\(productID)"
        guard let data = fullString.data(using: .utf8) else { return }
        
        networking.postRequestUrlEncoded(path: API.Enpoints.buyNonSub, body: data) { data, error, statusCode, headers in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            switch statusCode {
            case 201:
                guard let res = self.decodeJSON(type: PurchaseResponse.self, from: data) else {
                    completion(.failure(HttpErrors.decodeError))
                    return
                }
                completion(.success(res))
            case 500: completion(.failure(HttpErrors.unknowkError))
            case 401: completion(.failure(HttpErrors.unauthorized))
            default: completion(.failure(HttpErrors.unknowkError))
            }
        }
    }
    
    func searchQuestions(by query: String, completion: @escaping (Result<QuestionSearch, Error>) -> Void) {
        let params = [
            "q": query
        ]
        networking.request(path: API.Enpoints.search, params: params) { data, error, statusCode, headers in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            switch statusCode {
            case 200:
                guard let res = self.decodeJSON(type: QuestionSearch.self, from: data) else {
                    completion(.failure(HttpErrors.decodeError))
                    return
                }
                completion(.success(res))
            case 500: completion(.failure(HttpErrors.unknowkError))
            case 401: completion(.failure(HttpErrors.unauthorized))
            default: completion(.failure(HttpErrors.unknowkError))
            }
        }
    }
    
    func questionPreview(to id: Int, completion: @escaping (Result<QuestionPreviewModel, Error>) -> Void) {
        let fullPath = API.Enpoints.questionPreview + "\(id)"
        networking.request(path: fullPath, params: [:]) { data, error, statusCode, headers in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            switch statusCode {
            case 200:
                guard let res = self.decodeJSON(type: QuestionPreviewModel.self, from: data) else {
                    completion(.failure(HttpErrors.decodeError))
                    return
                }
                completion(.success(res))
            case 500: completion(.failure(HttpErrors.unknowkError))
            case 401: completion(.failure(HttpErrors.unauthorized))
            default: completion(.failure(HttpErrors.unknowkError))
            }
        }
    }
    
    
    func auth(uuid: String, playerID: String, url: String, isModal: Bool, completion: @escaping (Result<(token: String, user: User), Error>) -> Void) {
        let ismodal = isModal ? "chat" : ""
        let fullString = "key=\(API.apiKey)&uuid=\(uuid)&include_player_id=\(playerID)&url=\(url)&modal=\(ismodal)&time=\(Date.init().toString())"
        guard let data = fullString.data(using: .utf8) else { return }
        
        networking.postRequestUrlEncoded(path: API.Enpoints.auth, body: data) { data, error, statusCode, headers in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            switch statusCode {
            case 201:
                guard
                    let data = self.decodeJSON(type: User.self, from: data),
                    let res = headers as? [String: AnyObject],
                    let token = res.first(where: { $0.key == "Authorization"})?.value as? String
                else {
                    completion(.failure(HttpErrors.decodeError))
                    return
                }
            
                completion(.success((token, data)))
            case 400:
                guard
                    let error = self.decodeJSON(type: HttpError.self, from: data)?.message
                else {
                    completion(.failure(HttpErrors.unknowkError))
                    return
                }
                completion(.failure(HttpErrors.localizedOnServer(message: error)))
            case 401: completion(.failure(HttpErrors.unauthorized))
            default: completion(.failure(HttpErrors.unknowkError))
            }
        }
    }
    
    
}
