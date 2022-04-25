//
//  URLUtility.swift
//  Cinematic
//
//  Created by sagar patil on 24/04/2022.
//

import Foundation

struct URLUtility {
    let scheme = "https"
    let host = "imdb-api.com"
    let path = "/en/API/Top250Movies/k_17ojatu9"
}

extension URLUtility {
    func constructURL() -> URL {
        var urlComponents = URLComponents()
        
        urlComponents.host = self.host
        urlComponents.scheme = self.scheme
        urlComponents.path = self.path
        
        return urlComponents.url!
    }
}

