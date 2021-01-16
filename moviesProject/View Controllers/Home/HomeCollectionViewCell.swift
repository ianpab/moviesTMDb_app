//
//  HomeCollectionViewCell.swift
//  moviesProject
//
//  Created by Ian Pablo on 14/01/21.
//

import UIKit
import RxSwift
import WebKit




class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    
    func bindText(with movies: Similars){
        let year = movies.year
        let genre = movies.genre.joined(separator: ", ")
        self.ivPoster.loadImage(movies.posterUrl)
        self.lbTitle.text = movies.title
        self.lbDescription.text = "\(year)  \(genre)"

          
    }
    
}

