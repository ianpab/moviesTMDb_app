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
    
    var results: [Similars]{
        return movies
    }
//    
//    var overview:String {
//        return movies.first?.tagline ?? ""
//    }
    
    init(movies: [Similars]) {
        self.movies = movies
    }
}


//class MoviesViewModel {
//
//    public enum MovieError{
//        case internetError(String)
//        case serverError(String)
//    }
//
//    public let movieDetails:PublishSubject<[Movie]> = PublishSubject()
//    public let errors: PublishSubject<MovieError> = PublishSubject()
//
//    private let disposable = DisposeBag()
//
//    init() {
//
//    }
//
//    public func requestMovie(){
//        let teste = MoviesAPI().getMovies()
//        teste.subscribe(onNext: { self.movieDetails.onNext($0)}).disposed(by: disposable)
//      //  teste.bind(to: movieDetails).disposed(by: disposable)
//       // movieDetails.onNext(teste)
//    }
//
//}
