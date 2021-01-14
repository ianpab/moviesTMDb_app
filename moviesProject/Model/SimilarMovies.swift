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
       let url = "https://image.tmdb.org/t/p/w45\(poster_path)"
        return url
    }
    
}



//enum Genres: Int, Codable {
//    case acao = 28
//    case aventura = 12
//    case animacao = 16
//    case comedia = 35
//    case crime = 80
//    case documentario = 99
//    case drama = 18
//    case familia = 10751
//    case fantasia = 14
//    case historia = 36
//    case terror = 27
//    case musica = 10402
//    case misterio = 9648
//    case romance = 10749
//    case ficcao = 879
//    case cimena = 10770
//    case thriller = 53
//    case guerra = 10752
//    case faroeste = 37
//}

