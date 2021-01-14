//
//  MovieDataAPI.swift
//  moviesProject
//
//  Created by Ian Pablo on 11/01/21.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

enum EOError: Error {
  case invalidURL(String)
  case invalidParameter(String, Any)
  case invalidJSON(String)
  case invalidDecoderConfiguration
}


class MovieAPI {
    
    
//        static var somemovies: Observable<Movie> = {
//            let request: Observable<Movie> = MovieAPI.fetched()
//          return request
//            .share(replay: 1, scope: .forever)
//        }()
//
//     func fetched() -> Observable<Any> {
//        return Observable.create { observer in
//          //  var sucess: Movie = ""
//            _ = json(.get, "https://api.themoviedb.org/3/movie/464052?api_key=87a05d92a741ea095268306d2df30415&language=pt-BR")
//                .observe(on: MainScheduler.instance)
//                .subscribe(onNext:{ observer.onNext($0)})
//
//          //  observer.onNext(sucess)
//            return Disposables.create()
//
//        }}
        
        
    
//    static var movies: Observable<String> = {
//        let request: Observable<String> = MovieAPI.request()
//      return request
//        .share(replay: 1, scope: .forever)
//    }()
    
//    static var getmovies() ->  Observable<[Movie]> {
//        let request: Observable<[Movie]> = MovieAPI.request()
//      return request
//        .share(replay: 1, scope: .forever)
//    }
    
     func request() -> Observable<Movie> {
      do {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/464052?api_key=87a05d92a741ea095268306d2df30415&language=pt-BR"),
          let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            
            throw EOError.invalidURL("eer")
        }

        guard let finalURL = components.url else {
            throw EOError.invalidURL("erer")

        }

        let request = URLRequest(url: finalURL)

        return URLSession.shared.rx.response(request: request)
          .map { (result: (response: HTTPURLResponse, data: Data)) -> Movie in
            let decoder = JSONDecoder()
            let envelope = try decoder.decode(Movie.self, from: result.data)
            print("sefm array \(envelope)")
            return envelope
            
        }
      } catch {
        return Observable.empty()
      }
    }
    
    func get() -> Observable<Movie> {
       return Observable.create { observer in
           let comps = URLComponents(string: "https://api.themoviedb.org/3/movie/464052?api_key=87a05d92a741ea095268306d2df30415&language=pt-BR")!
           let stringURL = try! comps.asURL()

           AF.request(stringURL).responseJSON { (response) in
               guard let data = response.data,
                   let json = try? JSONDecoder().decode(Movie.self, from: data) else {
                   observer.onError(Fail.invalidParameter)
               return
             }

             observer.onNext(json)
             observer.onCompleted()
           }
           return Disposables.create {
           }

     }
   }
    
}



//typealias JSONObject = [String: Any]
//let disposeBag = DisposeBag()
//
//enum EOError: Error {
//  case invalidURL(String)
//  case invalidParameter(String, Any)
//  case invalidJSON(String)
//  case invalidDecoderConfiguration
//}
//
//class MovieAPI {
////    static let api = "https://api.themoviedb.org/3/movie/464052?api_key=87a05d92a741ea095268306d2df30415&language=pt-BR"
//
//
//    // MARK: - API Addresses
//    private let baseURL = "https://api.themoviedb.org/3/movie/"
//    private let apiKey = "87a05d92a741ea095268306d2df30415"
//    private let language = "pt-BR"
//
//    // MARK: - API Endpoint Requests
//     func movies(_ id: Int) -> Observable<[JSONObject]> {
//        let url = "https://api.themoviedb.org/3/movie/\(id)"
//        return request(address: url , parameters: ["api_key": apiKey , "language": language])
//    }
//
//    func similarMovies(_ id: Int) -> Observable<[JSONObject]> {
//        let url = "https://api.themoviedb.org/3/movie/\(id)/similar"
//        return request(address: url, parameters:  ["api_key": apiKey , "language": language])
//    }
//
//
//
//
//
//    // MARK: - generic request
//     private func get<Movie>(address: String, parameters: [String: String] = [:]) -> Observable<Movie> {
//        return Observable.create { observer in
//          var comps = URLComponents(string: address)!
//          comps.queryItems = parameters.sorted{ $0.0 < $1.0 }.map(URLQueryItem.init)
//            let stringURL = try! comps.asURL()
//
//            let request = AF.request(stringURL.absoluteString, method: .get)
//
//            request.responseJSON { response in
//              guard response.error == nil, let data = response.data,
//                let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? T) as T??), let result = json else {
//                observer.onError(EOError.invalidDecoderConfiguration)
//                return
//              }
//
//              observer.onNext(result)
//              observer.onCompleted()
//            }
//            return Disposables.create {
//              request.cancel()
//            }
//
//      }
//    }
//}
