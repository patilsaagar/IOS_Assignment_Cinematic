//
//  MovieResourceTests.swift
//  CinematicTests
//
//  Created by sagar patil on 21/04/2022.
//

import XCTest
@testable import Cinematic

class MovieRepositoryMock: MovieRepositoryProtocol {
    let isSuccessResponse: Bool
    
    init(isSuccessResponse: Bool) {
        self.isSuccessResponse = isSuccessResponse
    }
    
    func getMovies(completion: @escaping (Result<[MovieDetail]?, ApiError>) -> Void) {
        if let fileLocation = Bundle.main.url(forResource: "MovieData", withExtension: "json") {
            
            // do catch in case of an error
            do {
                let fileData = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let responseData = try? jsonDecoder.decode(MovieData.self, from: fileData)
                
                if self.isSuccessResponse {
                    completion(.success(responseData?.movieDetails))
                } else {
                    completion(.failure(.nilData))
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}

class MovieResourceTests: XCTestCase {
    
    var movieResourceMock: MovieRepositoryMock! = nil
    
    func testGetMovieWithSuccessResponse() {
        self.movieResourceMock = MovieRepositoryMock(isSuccessResponse: true)
        self.movieResourceMock.getMovies { result in
            switch result {
            case .success(let movieDetails):
                XCTAssertEqual(movieDetails?.first?.title, "The Shawshank Redemption")
                XCTAssertEqual(movieDetails?.first?.rank, "1")
                XCTAssertEqual(movieDetails?.first?.year, "1994")
                
            case .failure(_): break
            }
        }
    }
    
    func testGetMovieWithFailureResponse() {
        movieResourceMock = MovieRepositoryMock(isSuccessResponse: false)
        
        movieResourceMock.getMovies { result in
            switch result {
            case .success(_):
                break
                
            case .failure(let jsonError):
                XCTAssertEqual(ApiError.nilData.localizedDescription, jsonError.localizedDescription)
            }
        }
    }
}


