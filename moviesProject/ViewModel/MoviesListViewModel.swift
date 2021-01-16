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
    
    init(movieService: MoviesAPIProtocol = MoviesAPI()) {
        self.movieService = movieService
        
    }
    
    func fetchHomeMoviesViewModel(with id:Int) -> Observable<HomeViewModel>{
        movieService.request(with: id).map {
            HomeViewModel(moviesInfo: [$0])
        }
    }

    
    func fetchMoviesViewModel(with id:Int) -> Observable<MoviesViewModel>{
        movieService.get(id).map {
            MoviesViewModel(movies: $0.results)
        }
    }
   
    
    
    
}
