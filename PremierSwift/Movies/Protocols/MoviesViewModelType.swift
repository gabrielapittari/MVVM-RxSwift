//
//  MovieTableViewModelType.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 18/10/2017.
//

import RxSwift

// also need to know the results of the requests
protocol MoviesViewModelType {
    var errorObservable: Observable<String> { get }
    var moviesObservable: Observable<[MovieTableViewModelType]> { get }
    var elementsCountObservable: Observable<Int> { get }
    var itemSelected: PublishSubject<IndexPath> { get }
    func loadMore()
}
