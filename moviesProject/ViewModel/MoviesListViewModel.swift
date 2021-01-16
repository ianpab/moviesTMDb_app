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
    
    
    // Collection View
    
    var reuseIdentifier: String{
        return K.CollectionView.reuseIdentifier
    }
    
    var headerId:String {
        return K.CollectionView.headerId
    }
    
    var padding: CGFloat {
        return CGFloat(K.CollectionView.padding)
    }
    
    // Header View
    var iconHeart: String {
        return K.HeaderView.iconHeart }
    
    var iconHeartFill: String {
        return K.HeaderView.iconHeartFill}
    
    var iconPlayFill : String {
        return K.HeaderView.iconPlayFill }
    
    var defaultBanner: String {
        return K.HeaderView.defaultBanner }
    
    var defaultTitle : String {
        return K.HeaderView.defaultTitle  }
    
    // Colors
    
    var  white: String {
        return K.Colors.white
    }
    var blue: String {
        return K.Colors.blue
    }
    var black: String {
        return K.Colors.black
    }
}
   
