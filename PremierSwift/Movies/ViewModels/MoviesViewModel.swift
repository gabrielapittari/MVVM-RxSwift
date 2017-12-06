//
//  MovieViewModel.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 16/10/2017.
//
import Foundation
import Moya
import RxSwift
import RxCocoa
import ObjectMapper

final class MoviesViewModel: MoviesViewModelType {
    
    private let moviesProvider = MoyaProvider<TheMovieDB>()
    
    private let disposeBag = DisposeBag()
    
    var movieSelected = PublishSubject<Movie>()
    let itemSelected = PublishSubject<IndexPath>()
    
    private let error = PublishSubject<String>()
    lazy var errorObservable: Observable<String> = self.error.asObservable()
    
    private let movies = Variable<[(Movie, MovieTableViewModelType)]>([])
    lazy var moviesObservable: Observable<[MovieTableViewModelType]> = self.movies.asObservable().map { $0.map { $0.1 } }
    
    private let paginatedResults = Variable(PaginatedResults<Movie>())
    
    private let elementsCount = Variable(Int())
    lazy var elementsCountObservable: Observable<Int> = self.elementsCount.asObservable()
    
    let moviesDownloadQueueLabel = "moviesDownloadQueue"
    
    init() {
        // listening when a row is selected
        itemSelected
            .map { [weak self] in self?.movies.value[$0.row] }
            .subscribe(onNext: { [weak self] movie in
                guard let `self` = self, let movie = movie else { return }
                `self`.movieSelected
                    .onNext(movie.0)
            })
            .disposed(by: disposeBag)
        
        // future development: download data by page
        downloadMovies("\(paginatedResults.value.page + 1)")
    }
    
    func loadMore() {
        self.downloadMovies("\(self.paginatedResults.value.page + 1)")
    }
    
    func downloadMovies(_ page: String) {
        // making the movies request
        
        // reached max number of pages
        if paginatedResults.value.page > paginatedResults.value.totalPages {
            return
        }
        let moviesDownloadQueue = DispatchQueue(label: moviesDownloadQueueLabel)
        moviesDownloadQueue.async {
            self.moviesProvider.request(.paged(page)) { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case let .success(response):
                    // TODO move status codes to an enum
                    if response.statusCode >= 200 && response.statusCode <= 300 {
                        let dataString = String(data: response.data, encoding: .utf8)
                        // converting the data results into movies
                        let paginatedResults = Mapper<PaginatedResults<Movie>>().map(JSONString: dataString!)
                        guard paginatedResults != nil else {
                            self.error.onNext(LocalizableStrings.noResults.localized)
                            return
                        }
                        self.paginatedResults.value = paginatedResults!
                        guard (paginatedResults?.results) != nil else {
                            self.error.onNext(LocalizableStrings.noResults.localized)
                            return
                        }
                        let movies: [Movie] = paginatedResults!.results
                        // once I update the movies value, the whole table view and rows should update :)
                        self.movies.value.append(contentsOf: movies.map { ($0, MovieTableViewModel(movie: $0)) })
                        self.elementsCount.value = self.movies.value.count
                    } else {
                        self.error.onNext(LocalizableStrings.badRequest.localized)
                    }
                case .failure:
                    self.error.onNext("\(LocalizableStrings.requestError.localized)\(LocalizableStrings.tryAgainLater.localized)")
                }
            }
        }
    }
}

