//
//  MovieListCoordinator.swift
//  moviesProject
//
//  Created by Ian Pablo on 13/01/21.
//

import UIKit


final class MovieListCoordinator: Coordinator {
private(set) var childCoordinators:  [Coordinator] = []

private let navigationController: UINavigationController

init(navigationController: UINavigationController){
    self.navigationController = navigationController
}
    
    func start() {
        let homeViewController = HomeViewController.instantiate()
        let movieListViewModel = MoviesListViewModel()
        homeViewController.viewModel = movieListViewModel
        navigationController.setViewControllers([homeViewController], animated: false)
    }
}
