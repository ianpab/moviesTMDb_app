//
//  UIImageView.swift
//  moviesProject
//
//  Created by Ian Pablo on 15/01/21.
//

import UIKit

extension UIImageView{
    
    func loadImage(_ url: String){
        if let imageURL = URL(string: url) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
