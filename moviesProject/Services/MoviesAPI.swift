//
//  MoviesAPI.swift
//  moviesProject
//
//  Created by Ian Pablo on 12/01/21.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

enum Fail: Error {
  case invalidURL
  case invalidParameter

}

protocol MoviesAPIProtocol {
    func get() -> Observable<SimilarMovies>
}

class MoviesAPI: MoviesAPIProtocol {
    
    
    func request() -> Observable<Movie> {
     do {
       guard let url = URL(string: "https://api.themoviedb.org/3/movie/464052?api_key=87a05d92a741ea095268306d2df30415&language=pt-BR"),
         let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
           
           throw Fail.invalidURL
       }

       guard let finalURL = components.url else {
        throw Fail.invalidParameter

       }

       let request = URLRequest(url: finalURL)

       return URLSession.shared.rx.response(request: request)
         .map { (result: (response: HTTPURLResponse, data: Data)) -> Movie in
           let decoder = JSONDecoder()
           let envelope = try decoder.decode(Movie.self, from: result.data)
           print("lallalala \(envelope)")
           return envelope
           
       }
     } catch {
       return Observable.empty()
     }
   }
    
     func get() -> Observable<SimilarMovies> {
        return Observable.create { observer in
            let comps = URLComponents(string: "https://api.themoviedb.org/3/movie/464052/similar?api_key=87a05d92a741ea095268306d2df30415&language=pt-BR")!
            let stringURL = try! comps.asURL()

            AF.request(stringURL).responseJSON { (response) in
                guard let data = response.data,
                    let json = try? JSONDecoder().decode(SimilarMovies.self, from: data) else {
                    observer.onError(Fail.invalidParameter)
                return
              }
                print("JSONNN \(json)")
              observer.onNext(json)
              observer.onCompleted()
            }
            return Disposables.create {
            }

      }
    }
}
