//
//  HeaderView.swift
//  moviesProject
//
//  Created by Ian Pablo on 09/01/21.
//

import UIKit
import RxCocoa
import RxSwift

class HeaderView: UICollectionReusableView {
    
    var viewModel = MoviesListViewModel()

    var movies = BehaviorRelay<[Movie]>(value: [])
    var disposeBag = DisposeBag()
    var lbTitle: UILabel!
    var btHeart: UIButton!
    var heartType: Bool!
    var btLikes: UIButton!
    var btViews: UIButton!
    var imageView: UIImageView!
    let largeConfig = UIImage.SymbolConfiguration( scale: .large)
    let smallConfig = UIImage.SymbolConfiguration(scale: .small)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
        setupGradientLayer()
       
        btHeart.rx.tap.bind(onNext: { [self] in
            // toggle para alterar icone
            self.heartType = !self.heartType
            if self.heartType {
                self.btHeart.setImage(UIImage(systemName: viewModel.iconHeartFill, withConfiguration: largeConfig), for: .normal)
                } else {
                    self.btHeart.setImage(UIImage(systemName: viewModel.iconHeart, withConfiguration: largeConfig), for: .normal)
                }
        }).disposed(by: disposeBag)
    }
    
    func configure(with item: [Movie]) {
        movies.accept(item)
        
        movies
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] value in
                guard let self = self else { return }
                let banner = value.first?.bannerUrl ?? self.viewModel.defaultBanner
                let title = value.first?.title ?? self.viewModel.defaultTitle
                let views = value.first?.views ?? "0"
                let likes = value.first?.likes ?? "0"
                self.imageView.loadImage(banner)
                self.lbTitle.text = title
                self.btLikes.setTitle("  \(likes)  Curtidas" , for: .normal)
                self.btViews.setTitle("  \(views)  Views" , for: .normal)
                self.heartType = false
                self.btHeart.setImage(UIImage(systemName: self.viewModel.iconHeart, withConfiguration: self.largeConfig), for: .normal)
                
            }).disposed(by: disposeBag)
    }
    
    func createView(){
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
    }
    

    func setupGradientLayer(){
        // view com gradiente preto inferior
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(named: viewModel.black)!.cgColor]
        gradientLayer.locations = [0.5,1]
        // view para inserir a view do gradiente
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height
        
        // titulo
        lbTitle = UILabel()
        lbTitle.lineBreakMode = .byWordWrapping
        lbTitle.numberOfLines = 0
        lbTitle.font = .systemFont(ofSize: 24, weight: .heavy)
        lbTitle.textColor = UIColor(named: viewModel.white)
        lbTitle.textAlignment = .left
       
        // botao coracao
        heartType = Bool()
        btHeart = UIButton()
        btHeart.tintColor = UIColor(named: viewModel.white)
        btHeart.contentHorizontalAlignment = .right

        // botao likes
        btLikes = UIButton()
        btLikes.tintColor = UIColor(named: viewModel.blue)
        btLikes.titleLabel?.font = .systemFont(ofSize: 14)
        btLikes.setTitleColor(UIColor(named: viewModel.blue), for: .normal)
        btLikes.setImage(UIImage(systemName: viewModel.iconHeartFill,withConfiguration: smallConfig  ), for: .normal)
        btLikes.isUserInteractionEnabled = false
        btLikes.contentHorizontalAlignment = .left
        
        // botao views
        btViews = UIButton()
        btViews.tintColor = UIColor(named: viewModel.blue)
        btViews.titleLabel?.font = .systemFont(ofSize: 14)
        btViews.setTitleColor(UIColor(named: viewModel.blue), for: .normal)
        btViews.setImage(UIImage(systemName: viewModel.iconPlayFill,withConfiguration: smallConfig  ), for: .normal)
        btViews.isUserInteractionEnabled = false
        btViews.contentHorizontalAlignment = .left
        
        // stackview superior
        let firstLine = UIStackView(arrangedSubviews: [
        lbTitle, btHeart])
        firstLine.axis = .horizontal
        firstLine.distribution = .equalCentering
        firstLine.alignment = .top
        firstLine.spacing = -230
        
        // stackview inferior
        let secondLine = UIStackView(arrangedSubviews: [
        btLikes, btViews])
        secondLine.axis = .horizontal
        secondLine.distribution = .fillEqually
        secondLine.alignment = .fill
        
        // stackview que unifica as outras
        let stackView = UIStackView(arrangedSubviews: [
        firstLine, secondLine])
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Erro")
    }
}
