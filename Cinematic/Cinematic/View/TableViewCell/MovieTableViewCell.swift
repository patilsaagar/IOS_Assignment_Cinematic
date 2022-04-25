//
//  MovieTableViewCell.swift
//  Cinematic
//
//  Created by sagar patil on 21/04/2022.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var movieIMDBRating: UILabel!
    @IBOutlet private weak var movieCrew: UILabel!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
}

extension MovieTableViewCell {
    
    /// <#Description#>
    /// - Parameter movieData: Movie table cell data model
    func configureTableCell(with movieData: MovieDetail) {
        self.movieIMDBRating.text = movieData.imDbRating
        self.movieTitle.text = movieData.title
        self.movieCrew.text = movieData.crew
        
        if let movieImage = movieData.image,
           let movieImageURL = URL(string: movieImage) {
            self.movieImage.sd_setImage(with: movieImageURL, placeholderImage: nil, options: .highPriority, completed: nil)
            
            // Using UIImageView+LoadURLImage extension
            // self.movieImage.loadImageFrom(url: movieImageURL)
        }
    }
}
