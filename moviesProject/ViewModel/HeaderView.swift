//
//  HeaderView.swift
//  moviesProject
//
//  Created by Ian Pablo on 09/01/21.
//

import UIKit

class HeaderView: UICollectionReusableView {
        
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "header"))
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupGradientLayer()
    }
    
    fileprivate func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(named: "black")!.cgColor]
        gradientLayer.locations = [0.5,1]
        
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height
        
        let title = UILabel()
        title.text = "Mulher Maravilha 1984"
        title.font = .systemFont(ofSize: 24, weight: .heavy)
        title.textColor = UIColor(named: "white")
        
        let subtitle = UILabel()
        subtitle.text = "Este filme foi um sucesso de bilheteria no ano de 2021. Para muitos é considerado o melhor filme da DC."
        subtitle.font = .systemFont(ofSize: 14, weight: .regular)
        subtitle.textColor = UIColor(named: "white")
        subtitle.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [
        title, subtitle])
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Erro")
    }
}
