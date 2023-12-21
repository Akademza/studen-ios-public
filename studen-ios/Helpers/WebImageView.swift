//
//  WebImageView.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 17.03.2022.
//

import UIKit

class WebImageView: UIImageView {

    private var currentURlString: String?

    func setPhoto(by path: String) {
        
        let stringUrl = "https://\(API.host)/avatars/" + path
        
        currentURlString = stringUrl
        
        guard
            let url = URL(string: stringUrl)
        else {
            self.image = nil
            return
        }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self.image = UIImage(data: data)
                    self.handleLoadedImage(data: data, response: response)
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachesResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachesResponse, for: URLRequest(url: responseURL))
        
        if responseURL.absoluteString == currentURlString {
            self.image = UIImage(data: data)
        }
    }

}

