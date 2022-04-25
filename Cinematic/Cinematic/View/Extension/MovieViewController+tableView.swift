//
//  MovieViewController+tableView.swift
//  Cinematic
//
//  Created by sagar patil on 21/04/2022.
//

import UIKit

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.searchMovieFilterData.count > 0) ? viewModel.searchMovieFilterData.count : viewModel.movieTableCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTableViewCellIdentifier, for: indexPath) as! MovieTableViewCell
        
        var movieDetail = [MovieDetail]()
        
        if viewModel.searchMovieFilterData.count > 0 {
            movieDetail = viewModel.searchMovieFilterData
        } else {
            movieDetail = viewModel.movieTableCellData
        }
        
        movieCell.configureTableCell(with: movieDetail[indexPath.row])
        
        return movieCell
    }
}
