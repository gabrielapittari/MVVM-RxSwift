//
//  AppCoordinator.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 17/10/2017.
//
import Foundation

final class AppCoordinator: Coordinator {
    
    /// in case I have a login for a further expansion of this app, the start would allow me to initiate the app with a different VC, in this case we only have the Movies view as principal view
    func start() {
        let coordinator = MoviesCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func moviesCoordinatorCompleted(coordinator: MoviesCoordinator) {
        if let index = childCoordinators.index(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
