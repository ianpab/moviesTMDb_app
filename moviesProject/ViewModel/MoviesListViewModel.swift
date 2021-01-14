//
//  MoviesListViewModel.swift
//  moviesProject
//
//  Created by Ian Pablo on 13/01/21.
//

import Foundation
import RxSwift

final class MoviesListViewModel{
    
    private let movieService: MoviesAPIProtocol

    let titlee = "Casa da mae"
    
    init(movieService: MoviesAPIProtocol = MoviesAPI()) {
        self.movieService = movieService
        
    }
    
//    func fetchMoviesViewModel() -> Observable<MoviesViewModel>{
//        movieService.get().map {  MoviesViewModel(movies: [$0])}
//
//    }
    
    func fetchMoviesViewModel() -> Observable<MoviesViewModel>{
        movieService.get().map {
            MoviesViewModel(movies: $0.results)
        }
    }
    
//    func teste(){
//        MoviesAPI.loadHeros(id: 4444) { (movie) in
//            self.tracks.onNext(movie)        }
//    }
    
    
    
    
}
