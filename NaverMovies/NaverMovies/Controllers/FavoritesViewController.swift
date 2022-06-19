//
//  FavoritesViewController.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/16.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieInfoTableViewCell.self,
                           forCellReuseIdentifier: MovieInfoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var results: [MovieInfo]
    
    init() {
        self.results = FavoritesManager.shared.getFavoritesData()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.results = FavoritesManager.shared.getFavoritesData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "즐겨찾기 목록"
        setUpTable()
    }
    
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FavoritesViewController: UITableViewDelegate,
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieWebViewController(model: results[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
