//
//  MovieRepository.swift
//  Cinematic
//
//  Created by sagar patil on 21/04/2022
//

import Foundation

protocol MovieRepositoryProtocol {
    func getMovies(completion: @escaping (Result<[MovieDetail]?, ApiError>) -> Void)
}

class MovieRepository: MovieRepositoryProtocol {
    private let urlUtility: URLUtility
    private let httpPUtility: HTTPUtility
    
    init(urlUtility: URLUtility,
         httpPUtility: HTTPUtility) {
        self.urlUtility = urlUtility
        self.httpPUtility = httpPUtility
    }
    
    func getMovies(completion: @escaping (Result<[MovieDetail]?, ApiError>) -> Void) {
        
        let sourceURL = self.urlUtility.constructURL()
        var getMovieRequest = URLRequest(url: sourceURL)
        getMovieRequest.httpMethod = HTTPMethod.get.rawValue
        
        self.httpPUtility.getResponse(request: getMovieRequest, forType: MovieData.self) { movieResponse in
            switch movieResponse {
            case .success(let movies):
                completion(.success(movies.movieDetails))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
