//
//  Cinematic.swift
//  Cinematic
//
//  Created by sagar patil on 21/04/2022.
//

import XCTest
@testable import Cinematic

class MovieRepositorySuccessStubbed: MovieRepositoryProtocol {
    func getMovies(completion: @escaping (Result<[MovieDetail]?, ApiError>) -> Void) {
        completion(.success( [MovieDetail(id: "tt0111161",
                                          rank: "1",
                                          title: "The Shawshank Redemption",
                                          fullTitle: "The Shawshank Redemption (1994)",
                                          year: "1994",
                                          image: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UX128_CR0,3,128,176_AL_.jpg",
                                          crew: "Frank Darabont (dir.), Tim Robbins, Morgan Freeman",
                                          imDbRating: "9.2",
                                          imDbRatingCount: "2575845")
        ]
                           )
        )
    }
}

class MovieRepositoryFailureStubbed: MovieRepositoryProtocol {
    func getMovies(completion: @escaping (Result<[MovieDetail]?, ApiError>) -> Void) {
        completion(.failure(.nilData))
    }
}

class MovieDetailsViewModelMock: MovieDetailViewModelProtocol {
    var delegate: MoviewDetailAPIFetchProtocol?
    var movieTableCellData: [MovieDetail] = []
    var searchMovieFilterData: [MovieDetail] = []
    private var movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func getMovieDetails() {
        self.movieRepository.getMovies { result in
            switch result {
            case .success(let movies):
                self.movieTableCellData = movies ?? []
                
            case .failure(_):
                break
            }
        }
    }
    
    func filterMovieList(serchMovieName: String, completion: (Bool) -> Void) {}
}

class MovieDetailsViewModelTests: XCTestCase {
    
    func test_getMovieDetails_Success_Response() {
        
        // ARRANGE
        let repo = MovieRepositorySuccessStubbed()
        let sut = MovieDetailsViewModelMock(movieRepository: repo)
        
        
        // ACT
        sut.getMovieDetails()
        
        // Assert
        XCTAssertFalse(sut.movieTableCellData.isEmpty)
        XCTAssertEqual(sut.movieTableCellData.first?.title, "The Shawshank Redemption")
        XCTAssertEqual(sut.movieTableCellData.first?.id, "tt0111161")
        XCTAssertEqual(sut.movieTableCellData.first?.imDbRating, "9.2")
    }
    
    func test_getMovieDetails_Failure_Response() {
        
        // ARRANGE
        let repo = MovieRepositoryFailureStubbed()
        let sut = MovieDetailsViewModelMock(movieRepository: repo)
        
        
        // ACT
        sut.getMovieDetails()
        
        // Assert
        XCTAssertTrue(sut.movieTableCellData.isEmpty)
    }
    
    func test_filterMovieList() {
        // ARRANGE
        let movieRepositorySuccessStubbed = MovieRepositorySuccessStubbed()
        let sut = MovieDetailViewModel(movieRepository: movieRepositorySuccessStubbed)
        sut.getMovieDetails()
        
        
        // ACT
        sut.filterMovieList(serchMovieName: "The Shawshank Redemption") { result in
            XCTAssertEqual(result, true)
        }
        
        
    }
}
