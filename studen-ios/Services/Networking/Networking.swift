//
//  Networking.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 14.03.2022.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void)
    func postRequest(path: String, jsonBody: Data, completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void)
    func postRequest(path: String, params: [String: String], completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void)
    func postRequestUrlEncoded(path: String, body: Data, completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void)
    func putRequestUrlEncoded(path: String, body: Data, completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void)
}

class NetworkService {
    
    private lazy var udService = UDService.shared
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        
        components.host = API.host
        components.scheme = API.scheme
        if params != [:] {
            components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
            //components.queryItems = params.map { URLQueryItem(name: $0, value: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)) }
        }
        components.path = path
        
        return components.url!
    }
}

// MARK: Networking

extension NetworkService: Networking {
    
    func postRequestUrlEncoded(path: String, body: Data, completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void) {
        let allParams: [String: String] = [:]
//        allParams["version"] = API.version
//        allParams["os"] = API.os
        
        let url = self.url(from: path, params: allParams)
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
//        request.setValue("\(body.count)", forHTTPHeaderField: "Host")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        let bearer = "Bearer \(udService.getToken() ?? "")"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        request.httpBody = body
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func putRequestUrlEncoded(path: String, body: Data, completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void) {
        let allParams: [String: String] = [:]
//        allParams["version"] = API.version
//        allParams["os"] = API.os
        
        let url = self.url(from: path, params: allParams)
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.httpMethod = "PUT"
        
        let bearer = "Bearer \(udService.getToken() ?? "")"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        request.httpBody = body
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void) {
        let allParams = params
//        allParams["v"] = API.version
//        allParams["os"] = API.version
        let url = self.url(from: path, params: allParams)
        var request = URLRequest(url: url)
        let bearer = "Bearer \(udService.getToken() ?? "")"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func postRequest(path: String, jsonBody: Data, completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void) {
        var allParams: [String: String] = [:]
        allParams["version"] = API.version
        allParams["os"] = API.os
        let url = self.url(from: path, params: allParams)
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let bearer = "Bearer \(udService.getToken() ?? "")"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        request.httpBody = jsonBody
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func postRequest(path: String, params: [String: String], completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void) {
        var allParams: [String: String] = params
        allParams["version"] = API.version
        allParams["os"] = API.os
        let url = self.url(from: path, params: allParams)
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let bearer = "Bearer \(udService.getToken() ?? "")"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?, Int?, [AnyHashable: Any]) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(data, error, 400, [:])
            }
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse else { return }
                completion(data, error, response.statusCode, response.allHeaderFields)
            }
        }
    }
}

