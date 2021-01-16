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
    let backdrop_path: String
    let vote_count: Int
    
    var bannerUrl:String{
        let url = "https://image.tmdb.org/t/p/w780\(backdrop_path)"
        return url
    }
    
    var views: String {
        let number = formatNumber(Int(popularity))
        return number
    }
    
    var likes: String {
        let number = formatNumber(vote_count)
        return number
    }
}
