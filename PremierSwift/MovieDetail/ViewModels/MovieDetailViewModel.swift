//
//  MovieDetailViewModel.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 01/11/2017.
//

import Foundation
import RxSwift

final class MovieDetailViewModel: MovieDetailViewModelType {
    
    let name: Observable<String>
    
    init(movie: Movie) {
        name = .just(movie.title)
    }
    
}
