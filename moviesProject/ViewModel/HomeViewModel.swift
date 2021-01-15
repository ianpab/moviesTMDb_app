//
//  HomeViewModel.swift
//  moviesProject
//
//  Created by Ian Pablo on 14/01/21.
//

import Foundation
import RxSwift
import RxCocoa



struct HomeViewModel{
    
    private let moviesInfo: Movie
   

    var topMovie: Movie{
        return moviesInfo
    }
    

    init(moviesInfo: Movie) {
        self.moviesInfo = moviesInfo

    }
    
}
