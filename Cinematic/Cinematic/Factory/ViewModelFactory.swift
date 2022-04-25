//
//  ViewModelFactory.swift
//  Cinematic
//
//  Created by sagar patil on 22/04/2022.
//

// Created Model factory to resolve dependency
// For bigger application/ VM's count is more then we can go with Service locator pattern / Third party DI framework

class ViewModelFactory {
    static func getMovieViewModel() -> MovieDetailViewModelProtocol {
        let urlUtility = URLUtility()
        let httpPUtility = HTTPUtility.shared
        
        let movieRepository = MovieRepository(urlUtility: urlUtility, httpPUtility: httpPUtility)
        return MovieDetailViewModel(movieRepository: movieRepository)
    }
}
