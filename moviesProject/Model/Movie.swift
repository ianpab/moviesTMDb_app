//
//  MovieDataModel.swift
//  moviesProject
//
//  Created by Ian Pablo on 11/01/21.
//

import Foundation

struct Movie: Codable {
    let id: Int
   let title: String
    let overview: String
    let tagline: String
    let popularity: Double
    let poster_path: String
    let vote_count: Int
}
