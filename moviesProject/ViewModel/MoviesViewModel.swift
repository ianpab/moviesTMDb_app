//
//  MoviesModelView.swift
//  moviesProject
//
//  Created by Ian Pablo on 12/01/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources



struct MoviesViewModel{
    
    private let movies: [Similars]
    
    var similiarMovies: [Similars]{
        return movies
    }

    init(movies: [Similars]) {
        self.movies = movies
    }
    
}
