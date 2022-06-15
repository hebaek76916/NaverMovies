//
//  SearchResultController.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/14.
//

import UIKit

protocol SearchResultControllerDelegate: AnyObject {
    func searchResultViewController(searchResult: MovieResult)
}


class SearchResultController: UIViewController {
    
    weak var delegate: SearchResultControllerDelegate?
    
    private var results: [MovieInfo] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieInfoTableViewCell.self,
                           forCellReuseIdentifier: MovieInfoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    public func update(with results: [MovieInfo]) {
        self.results = results
        tableView.isHidden = results.isEmpty
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchResultController: UITableViewDelegate,
                                  UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier,
                                                       for: indexPath) as? MovieInfoTableViewCell else {
            return UITableViewCell()
        }
        let model = results[indexPath.row]
        cell.updateUI(model: model)
        return cell
    }
}
