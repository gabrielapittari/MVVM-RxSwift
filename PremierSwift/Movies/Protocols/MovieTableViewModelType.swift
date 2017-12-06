//
//  MovieTableViewModelType.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 18/10/2017.
//

import RxSwift
// defining the view model observables
protocol MovieTableViewModelType {
    var name: Observable<String> { get }
    var overview: Observable<String> { get }
    var voteAverage: Observable<String> { get }
    var posterPath: Observable<String> { get }
    var posterImage: Observable<UIImage> { get }
    var errorObservable: Observable<String> { get }
}

