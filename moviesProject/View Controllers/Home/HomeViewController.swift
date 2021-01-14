//
//  HomeViewController.swift
//  moviesProject
//
//  Created by Ian Pablo on 13/01/21.
//

import UIKit
import RxCocoa
import RxSwift
//import RxDataSources

private let reuseIdentifier = "Cell"
private let headerId = "headerId"
private let padding: CGFloat = 16


class HomeViewController: UIViewController,UICollectionViewDelegateFlowLayout {

    
    static func instantiate() -> HomeViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "home") as! HomeViewController

        return controller
    }
    
    
    @IBOutlet weak var headerCollection: UICollectionView!
    var viewModel: MoviesListViewModel!
    let disposeBag = DisposeBag()
    let movies = BehaviorRelay<[Similars]>(value: [])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerCollection.delegate = self
        headerCollection.dataSource = self
        setupCollectionView()
        setupCollectionViewLayout()
        navigationController?.navigationBar.isHidden = true
        
        movies
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.headerCollection.reloadData()
                }
            }).disposed(by: disposeBag)
        
        bindUI()
            
    }
    
    
    // MARK: - Methods
    
    func bindUI(){
        let data = viewModel.fetchMoviesViewModel()
            .map{ $0.results}
        
        data
            .bind(to: movies)
            .disposed(by: disposeBag)
            }
    }
   
extension HomeViewController: UICollectionViewDataSource{


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return movies.value.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        let similarMovies = movies.value[indexPath.row]
        cell.bindText(with: similarMovies)
        
        cell.backgroundColor = .white
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * padding, height: 80)
    }

}



extension HomeViewController: UICollectionViewDelegate{
    
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .init(width: view.frame.width, height: 400)
    }
    
     func setupCollectionView() {
        // Define o header e cells
       // headerCollection!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        headerCollection.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        headerCollection.collectionViewLayout = HeaderLayout()
    }
    // layout da collection
     func setupCollectionViewLayout() {
        headerCollection.backgroundColor = UIColor(named: "black")
        headerCollection.contentInsetAdjustmentBehavior = .never

        if let layout = headerCollection.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }

    }
}


