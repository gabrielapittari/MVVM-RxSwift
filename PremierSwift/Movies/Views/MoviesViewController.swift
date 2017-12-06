import Foundation
import Moya
import UIKit
import RxSwift
import RxCocoa

protocol MoviesTableViewControllerDelegate: class {
    func movieSelected(movie: Movie)
    func loadMore()
}

class MoviesViewController: UIViewController {
    
    let movieTableViewCellIdentifier = "MovieTableViewCell"
    let movieCellIdentifier = "movieCell"
    var viewModel: MoviesViewModelType!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    var elementsCount: Int = 0
    
    convenience init(viewModel: MoviesViewModelType) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = LocalizableStrings.topMovies.localized
        
        let nib = UINib(nibName: movieTableViewCellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: movieCellIdentifier)
        
        // the height of my rows is dynamic
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.delegate = self
        
        // observing when selecting a row of the tableview
        tableView.rx.itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        // observing the amount of elements to trigger pagination
        viewModel.elementsCountObservable
            .subscribe(onNext: { count in
                self.elementsCount = count
            }).disposed(by: disposeBag)
        
        // setting the observable for the rows of the tableview
        viewModel.moviesObservable
            .bind(to: tableView.rx.items) { tableView, i, item in
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: self.movieCellIdentifier, for: indexPath) as! MovieTableViewCell
                cell.movieViewModel = item
                
                // setting UI for each cell
                cell.nameLabel.font = .title
                cell.averageLabel.font = .subtitle
                cell.descriptionLabel.font = .body
                
                cell.nameLabel.textColor = .titleText
                cell.averageLabel.textColor = .subtitleText
                cell.descriptionLabel.textColor = .bodyText
                return cell
            }
            .disposed(by: disposeBag)
        
        // observable for errors from the server request
        viewModel.errorObservable
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(LocalizableStrings.error.localized, message: error)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: LocalizableStrings.ok.localized, style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // paging
        if indexPath.row == elementsCount - 1 {
            self.viewModel.loadMore()
        }
    }
}
