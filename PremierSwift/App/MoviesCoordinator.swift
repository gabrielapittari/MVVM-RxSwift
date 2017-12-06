//
//  MoviesCoordinator.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 17/10/2017.
//
import UIKit
import RxSwift

final class MoviesCoordinator: Coordinator {
    
    var movieSelected = PublishSubject<Movie>()
    let disposeBag = DisposeBag()
   
    override init(navigationController: UINavigationController?) {
        super.init(navigationController: navigationController)
        
//        movieSelected
//            .subscribe(onNext: { movie in
//                let viewModelMovie = MovieDetailViewModel(movie: movie)
//                let viewController = MovieDetailViewController(viewModel: viewModelMovie)
//                self.navigationController?.pushViewController(viewController, animated: true)
//            }).disposed(by: disposeBag)
    }
    
    func start() {
        let viewModel = MoviesViewModel()
        let viewController = MoviesViewController(viewModel: viewModel)
        
        viewModel.movieSelected.asObservable()
            .bind(to: movieSelected)
            .disposed(by: disposeBag)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

