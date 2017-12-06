//
//  MovieDetailViewModelType.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 01/11/2017.
//

import Foundation
import RxSwift

protocol MovieDetailViewModelType {
    var name: Observable<String> { get }
}
