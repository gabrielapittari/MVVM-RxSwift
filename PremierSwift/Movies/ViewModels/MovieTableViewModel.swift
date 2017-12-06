//
//  MovieTableViewModel.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 18/10/2017.
//

import Moya
import RxSwift
import RxCocoa

final class MovieTableViewModel: MovieTableViewModelType {
    
    let name: Observable<String>
    let overview: Observable<String>
    let voteAverage: Observable<String>
    let posterPath: Observable<String>
    var posterImage: Observable<UIImage>
    
    private let error = PublishSubject<String>()
    lazy var errorObservable: Observable<String> = self.error.asObservable()
    
    private let imagesProvider = MoyaProvider<ImageTMDB>()
    
    init(movie: Movie) {
        // set values retrieved from movie object to the view model
        name = .just(movie.title)
        overview = .just(movie.overview)
        voteAverage = .just("⭐️ \(movie.voteAverage)")
        posterPath = .just(movie.posterPath)
        posterImage = .just(movie.posterImage)
        self.downloadImage(movie.posterPath)
    }
    
    func downloadImage(_ id: String) {
        imagesProvider.request(.posterId(id)) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case let .success(response):
                // TODO move status codes to a enum
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    let image = UIImage(data: response.data)
                    if (image != nil) {
                        self.posterImage = .just(image!)
                    }
                } else {
                    self.error.onNext(LocalizableStrings.badRequest.localized)
                }
            case .failure:
                self.error.onNext("\(LocalizableStrings.requestError.localized)\(LocalizableStrings.tryAgainLater.localized)")
            }
        }
    }
}
