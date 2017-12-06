//
//  MovieDetailViewController.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 01/11/2017.
//

import Foundation
import UIKit
import RxSwift

class MovieDetailViewController: UIViewController {
    
    var viewModel: MovieDetailViewModelType!
    
    @IBOutlet weak var viewLabel: UILabel!
    let disposeBag = DisposeBag()
    
    convenience init(viewModel: MovieDetailViewModelType) {
        self.init()
        self.viewModel = viewModel
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.name.bind(to: viewLabel.rx.text).disposed(by: disposeBag)
    }
}
