//
//  SimilarMovies.swift
//  moviesProject
//
//  Created by Ian Pablo on 13/01/21.
//

import Foundation

struct SimilarMovies: Codable {
    let results: [Similars]
}

struct Similars: Codable {
    let id: Int
    let title: String
    let poster_path: String
    let genre_ids: [Int]
    let release_date: String
    
    var posterUrl:String {
       let url = "https://image.tmdb.org/t/p/w92\(poster_path)"
        return url
    }
    
  
    
}

