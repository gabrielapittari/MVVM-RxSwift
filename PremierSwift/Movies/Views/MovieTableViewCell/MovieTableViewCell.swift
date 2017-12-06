//
//  MovieCell.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 13/10/2017.
//

import UIKit
import RxSwift

class MovieTableViewCell: UITableViewCell {
    private var disposeBag = DisposeBag()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var averageLabel: UILabel!
    
    var movieViewModel: MovieTableViewModelType? {
        willSet {
            disposeBag = DisposeBag()
        }
        didSet {
            setupBindings()
        }
    }
    
    // asigning the value of the view model to the view
    func setupBindings() {
        guard let viewModel = movieViewModel else { return }
        viewModel.name.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.overview.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.voteAverage.bind(to: averageLabel.rx.text).disposed(by: disposeBag)
        viewModel.posterImage.bind(to: posterImageView.rx.image).disposed(by: disposeBag)
        
    }
    
}

