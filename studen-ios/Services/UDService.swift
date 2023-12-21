//
//  UDService.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 14.03.2022.
//

import Foundation

class UDService {
    
    static let shared = UDService()
    
    private let storage = UserDefaults.standard
    private init() { }
    
    struct Contants {
        static let token = "token"
        static let isPushEnabled = "isPushEnabled"
    }
    
    func setToken(_ token: String) {
        storage.setValue(token, forKey: Contants.token)
    }
    
    func getToken() -> String? {
        storage.value(forKey: Contants.token) as? String
    }
    
    func isPushEnabled() -> Bool {
        let value = storage.value(forKey: Contants.isPushEnabled) as? Bool
        return value ?? false
    }
    
    func changePushEnabled(_ value: Bool) {
        storage.setValue(value, forKey: Contants.isPushEnabled)
    }
    
    func clearData() {
        storage.removeObject(forKey: Contants.token)
    }
    
}
