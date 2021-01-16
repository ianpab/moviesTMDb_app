//
//  HomeCollectionViewCell.swift
//  moviesProject
//
//  Created by Ian Pablo on 14/01/21.
//

import UIKit
import RxSwift
import WebKit

enum Genres: Int {
    case acao = 28
    case aventura = 12
    case animacao = 16
    case comedia = 35
    case crime = 80
    case documentario = 99
    case drama = 18
    case familia = 10751
    case fantasia = 14
    case historia = 36
    case terror = 27
    case musica = 10402
    case misterio = 9648
    case romance = 10749
    case ficcao = 879
    case cimena = 10770
    case thriller = 53
    case guerra = 10752
    case faroeste = 37
}


class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    
    func bindText(with movies: Similars){
        self.ivPoster.loadImage(movies.posterUrl)
        self.lbTitle.text = movies.title
        self.lbDescription.text = movies.release_date
          
    }
    
}

