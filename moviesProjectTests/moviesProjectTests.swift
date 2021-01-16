//
//  moviesProjectTests.swift
//  moviesProjectTests
//
//  Created by Ian Pablo on 16/01/21.
//

import XCTest
@testable import moviesProject

class moviesProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSimilarMovies(){
        let movies = [Similars(id: 12, title: "Ben10", poster_path: "some.jpg", genre_ids: [16,14], release_date: "2021-01-01")]
        let moviesViewModel = MoviesViewModel(movies: movies)
        
        // test values
        XCTAssertEqual(movies[0].title, moviesViewModel.similiarMovies[0].title)
        XCTAssertEqual(movies[0].genre, ["Animação", "Fantasia"] )
        XCTAssertEqual(movies[0].year, "2021" )
    }
    
    func testHomeMovie(){
        let topMovie = [Movie(id: 12, title: "Matrix", overview: "Trilogia Matrix", tagline: "O que é Matrix", popularity: 47.438, poster_path: "matrix.jpg", backdrop_path: "banner.jpg", vote_count: 3304)]
        let homeViewModel = HomeViewModel(moviesInfo: topMovie)
        
        XCTAssertEqual(topMovie[0].id, homeViewModel.topMovie[0].id)
        XCTAssertEqual(topMovie[0].views, homeViewModel.topMovie[0].views)
        XCTAssertEqual(topMovie[0].likes, "3.3K")
        
    }

}
