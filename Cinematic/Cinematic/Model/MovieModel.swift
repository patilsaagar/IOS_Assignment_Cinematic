//
//  MovieModel.swift
//  Cinematic
//
//  Created by sagar patil on 21/04/2022.
//

import Foundation

struct MovieData: Decodable {
    let movieDetails: [MovieDetail]?
    
    enum CodingKeys: String, CodingKey {
        case movieDetails = "items"
    }
}

struct MovieDetail: Decodable {
    let id: String
    let rank: String?
    let title: String?
    let fullTitle: String?
    let year: String?
    let image: String?
    let crew: String?
    let imDbRating: String?
    let imDbRatingCount: String?
}
