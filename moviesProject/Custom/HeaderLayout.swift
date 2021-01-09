//
//  HeaderLayout.swift
//  moviesProject
//
//  Created by Ian Pablo on 09/01/21.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {

    // Modificar atributos do header
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attributes) in
            
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                
                guard let collectionView = collectionView else { return }
            // pega a posicao Y do collection view
                let contentOffsetY = collectionView.contentOffset.y
               
                if contentOffsetY > 0 {
                    return
                }
            // define a largura do collection view
                let width = collectionView.frame.width
           //   define a altura do header menos a posicao Y
                let height = attributes.frame.height  - contentOffsetY
                
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
        })
        
        return layoutAttributes
    }
    
    // Permitir alteracoes do Offset
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
