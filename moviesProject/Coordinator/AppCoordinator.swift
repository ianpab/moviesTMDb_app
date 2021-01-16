//
//  AppCoordinator.swift
//  moviesProject
//
//  Created by Ian Pablo on 13/01/21.
//

import Foundation
import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
    
}

final class AppCoordinator: Coordinator{
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    
    func start(){
        let navigationController = UINavigationController()
        
        let movieListCoordinator = MovieListCoordinator(navigationController: navigationController)
        
        childCoordinators.append(movieListCoordinator)
        movieListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
