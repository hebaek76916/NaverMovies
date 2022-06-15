//
//  ViewController.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/13.
//

import UIKit

class ViewController: UIViewController {

    private var searchTimer: Timer?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieInfoTableViewCell.self,
                           forCellReuseIdentifier: MovieInfoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "영화이름"
        return searchBar
    }()
    
    private var result: [MovieInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSearchController()
    }

}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
     
        guard let query = searchController.searchBar.text,
              let resultVC = searchController.searchResultsController as? SearchResultController,
              !(query.trimmingCharacters(in: .whitespaces).isEmpty) else {
                  return
              }
        
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3,
                                           repeats: false,
                                           block: { _ in
            
            APICaller.search(query: query) { result in
                
                guard let result = result else {
                    return
                }
        
                resultVC.update(with: result.items ?? [])
            }
        })
    }
}

extension ViewController: SearchResultControllerDelegate {
    func searchResultViewController(searchResult: MovieResult) {
        
    }
}

extension ViewController {
    
    private func setUpSearchController() {
        let resultVC = SearchResultController()
        resultVC.delegate = self
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
    
}
