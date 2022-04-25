//
//  MovieViewController.swift
//  Cinematic
//
//  Created by sagar patil on 21/04/2022.
//

import UIKit

class MovieViewController: UIViewController {
    // MARK: Variables
    var viewModel: MovieDetailViewModelProtocol = ViewModelFactory.getMovieViewModel()
    lazy var movieSearchBar: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchResultsUpdater = self
        searchBar.searchBar.delegate = self
        return searchBar
    }()
    
    
    @IBOutlet weak var movieTableView: UITableView! {
        didSet {
            let nibName = UINib(nibName: Constants.movieTableViewCellIdentifier, bundle: nil)
            movieTableView.register(nibName, forCellReuseIdentifier: Constants.movieTableViewCellIdentifier)
            movieTableView.estimatedRowHeight = 300
            movieTableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Title.homeViewControllerTitle
        navigationItem.searchController = movieSearchBar
        
        self.initalizeMovieViewModel()
    }
    
    
    // MARK: Private Method
    private func initalizeMovieViewModel() {
        viewModel.getMovieDetails()
        viewModel.delegate = self
    }
}

extension MovieViewController: MoviewDetailAPIFetchProtocol {
    func didFetchMovieData(movieDetails: [MovieDetail]?) {
        DispatchQueue.main.async {
            if movieDetails == nil {
                self.showAlert(alertTitle: Constants.alertTitle, alertMessgae: Constants.downloadError)
            } else {
                self.movieTableView.reloadData()
            }
        }
    }
}

extension MovieViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterMovieList(serchMovieName: searchController.searchBar.text ?? "", completion: { [weak self] isValuePresent in
            if isValuePresent {
                self?.movieTableView.reloadData()
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async { [weak self] in
            self?.movieTableView.reloadData()
        }
    }
}
