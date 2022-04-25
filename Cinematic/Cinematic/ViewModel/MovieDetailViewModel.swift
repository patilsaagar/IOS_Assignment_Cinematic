//
//  MovieDetailViewModel.swift
//  Cinematic
//
//  Created by sagar patil on 21/04/2022.
//

import Foundation

// Delegate to pass movie details to movie viewcontroller
// This can be acheive using Combine/ Boxing
protocol MoviewDetailAPIFetchProtocol: AnyObject {
    func didFetchMovieData(movieDetails: [MovieDetail]?)
}

protocol MovieDetailViewModelProtocol: AnyObject {
    var delegate: MoviewDetailAPIFetchProtocol? { get set }
    var movieTableCellData: [MovieDetail] { get set }
    var searchMovieFilterData: [MovieDetail] { get set }
    
    func getMovieDetails()
    func filterMovieList(serchMovieName: String, completion: (Bool) -> Void)
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var movieTableCellData: [MovieDetail] = []
    var searchMovieFilterData: [MovieDetail] = []
    private var movieRepository: MovieRepositoryProtocol
    weak var delegate: MoviewDetailAPIFetchProtocol?
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    // MARK: Public Methods
    
    func getMovieDetails() {
        self.movieRepository.getMovies { [weak self] movieResponse in
            switch movieResponse {
            case .success(let movieDetails):
                self?.delegate?.didFetchMovieData(movieDetails: movieDetails)
                self?.movieTableCellData = movieDetails ?? []
            case .failure(_):
                self?.delegate?.didFetchMovieData(movieDetails: nil)
            }
        }
    }
    
    func filterMovieList(serchMovieName: String, completion: (Bool) -> Void) {
        searchMovieFilterData = self.movieTableCellData.filter({ (movie: MovieDetail) -> Bool in
            return movie.title?.lowercased().contains(serchMovieName.lowercased()) ?? false
        })
        
        searchMovieFilterData.count > 0 ? completion(true) : completion(false)
    }
}
