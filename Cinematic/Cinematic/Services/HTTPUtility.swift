//
//  APIManager.swift
//  Cinematic
//
//  Created by sagar patil on 21/04/2022.
//

import Foundation

enum HTTPMethod : String {
    case get
    case post
}


/* Reason to have different error types is so that
 during debugging we know what kind of error message is enountered
 */

enum ApiError : Error {
    case serverError
    case jsonDecoder
    case errorHttpStatusCode
    case nilData
    case invalidJSON(Error?)
}

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

final class HTTPUtility {
    
    static let shared = HTTPUtility()
    
    private init() {}
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - request: Request URL
    ///   - forType: Model Type
    ///   - completion: completion block to return the result
    func getResponse<T: Decodable>(request: URLRequest, forType: T.Type, completion: @escaping ( Result<T, ApiError>) -> Void) {
        
        performDataOperations(request: request, forType: T.self) { apiResponse in
            switch apiResponse {
            case .success(let response):
                completion(.success(response))
            case .failure( let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: Private functions
    
    private func performDataOperations<T:Decodable>(request: URLRequest, forType: T.Type, completion: @escaping ( Result<T, ApiError>) -> Void) {
        
        URLSession.shared.dataTask(with: request) { data, httpResponse, error in
            
            // if there is a server error then return api error server
            if(error != nil) {
                completion(.failure(ApiError.errorHttpStatusCode))
            }
            
            // if the httpstatus code is not in the range of 200 then return error
            if let response = httpResponse as? HTTPURLResponse, !(200 ... 299).contains(response.statusCode) {
                completion(.failure(ApiError.errorHttpStatusCode))
            }
            
            // if the data received from server is nil then return error
            if(data == nil) {
                completion(.failure(ApiError.nilData))
            }
            
            
            do {
                let jsonDecoder = JSONDecoder()
                
                if let responseData = data {
                    let result = try jsonDecoder.decode(T.self, from: responseData)
                    completion(.success(result))
                } else {
                    completion(.failure(.invalidJSON(error)))
                }
            } catch let error {
                debugPrint(error.localizedDescription)
                completion(.failure(ApiError.jsonDecoder))
            }
            
        }.resume()
    }
}
