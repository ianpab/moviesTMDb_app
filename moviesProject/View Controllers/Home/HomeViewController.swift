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

class HomeViewController: UIViewController,UICollectionViewDelegateFlowLayout {

    
    static func instantiate() -> HomeViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "home") as! HomeViewController

        return controller
    }
    
    
    @IBOutlet weak var headerCollection: UICollectionView!
    var viewModel: MoviesListViewModel!
    var headerView: HeaderView!
    static let padding = 16
    let disposeBag = DisposeBag()
    var topMovie = BehaviorRelay<[Movie]>(value: [])
    var movies = BehaviorRelay<[Similars]>(value: [])
    var movieId = BehaviorRelay<Int>(value: 464052)

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
                    self?.headerCollection.setContentOffset(CGPoint(x:0,y:0), animated: true)

                }
            }).disposed(by: disposeBag)
           
        bindUI()
            
    }
    
    
    // MARK: - Methods
    
    func bindUI(){
      
        movieId
           .asObservable()
            .observeOn(MainScheduler.instance)
           .subscribe(onNext: { [unowned self] id in
            self.fetchdados()
           })
           .disposed(by: disposeBag)
        }
    
    func fetchdados(){
        let data = viewModel.fetchHomeMoviesViewModel(with: movieId.value)
            .map{ $0.topMovie}
        data
            .observeOn(MainScheduler.instance)
            .bind(to: topMovie)
            .disposed(by: disposeBag)

        let update = viewModel.fetchMoviesViewModel(with: movieId.value)
            .map{ $0.results}
        
            update
                .observeOn(MainScheduler.instance)
                .bind(to: movies)
            .disposed(by: disposeBag)
        
    }
    
    }
   
extension HomeViewController: UICollectionViewDataSource{


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.value.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        let similarMovies = movies.value[indexPath.row]
        cell.bindText(with: similarMovies)
        
        cell.backgroundColor = .white
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * viewModel.padding, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieSelected = movies.value[indexPath.row]
        movieId.accept(movieSelected.id)
    }
}



extension HomeViewController: UICollectionViewDelegate{
    
  
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: viewModel.headerId, for: indexPath) as? HeaderView {
      
            topMovie
                .observeOn(MainScheduler.instance)
                .subscribe(onNext:{ value in
                    headerView.configure(with: value)
            }).disposed(by: disposeBag)
    
                    return headerView
                }
                return UICollectionReusableView()
            }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .init(width: view.frame.width, height: 400)
    }
    
     func setupCollectionView() {
        // Define o header e cells
        headerCollection.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: viewModel.headerId)
        headerCollection.collectionViewLayout = HeaderLayout()
    }
    // layout da collection
     func setupCollectionViewLayout() {
        headerCollection.backgroundColor = UIColor(named: viewModel.black)
        headerCollection.contentInsetAdjustmentBehavior = .never

        if let layout = headerCollection.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = .init(top: viewModel.padding , left: viewModel.padding, bottom:viewModel.padding, right: viewModel.padding)
        }

    }
}



