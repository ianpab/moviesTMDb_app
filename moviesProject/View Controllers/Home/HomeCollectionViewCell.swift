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
    @IBOutlet weak var wkPoster: WKWebView!
    
    func bindText(with text: Similars){
        self.lbTitle.text = text.title
        self.lbDescription.text = text.release_date
        
        if let setUrl = URL(string: text.posterUrl) {
            wkPoster.load(URLRequest(url: setUrl))
            wkPoster.allowsBackForwardNavigationGestures = false
            wkPoster.isUserInteractionEnabled = false
            
                   }
               
    }
    
}

