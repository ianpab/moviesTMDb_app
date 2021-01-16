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

    var year: String{
        let year = release_date[0..<4]
        return year
    }
    
    var genre: [String]{
        var result:[String] = []
        for i in 0..<2 {
            result.append(dict.someKey(forValue: genre_ids[i]) ?? "")
        }
        return result
    }
   
}

let dict: [String: Int] = ["Ação": 28, "Aventura": 12, "Animação": 16, "Comédia": 35, "Crime":80, "Documentário": 99, "Drama": 18, "Família": 10751, "Fantasia": 14, "História": 36, "Terror": 27, "Música": 10402, "Mistério": 9648, "Romance":10749, "Ficção": 878, "Cinema": 10770, "Thriller": 53, "Guerra": 10752, "Faroeste": 37 ]


