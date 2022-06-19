//
//  ViewController.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/13.
//

import UIKit

class ViewController: UIViewController {

    private var searchTimer: Timer?
    private var results: [MovieInfo] = []
        
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
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        navigationItem.title = "네이버 영화 검색"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func moveToFavorites() {
        let vc = FavoritesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        guard let query = searchBar.text,
              !(query.trimmingCharacters(in: .whitespaces).isEmpty) else {
                  results = []
                  DispatchQueue.main.async {
                      self.tableView.reloadData()
                  }
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
                print(result)
                DispatchQueue.main.async {
                    self.results = result.items ?? []
                    self.tableView.reloadData()
                }
            }
        })
    }
}

extension ViewController: UITableViewDelegate,
                          UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
extension ViewController {
    func setUpUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        [
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor,
                                          constant: 68),
            searchBar.heightAnchor.constraint(equalToConstant: 80)
        ].forEach{ $0.isActive = true }
        
        view.addSubview(tableView)
        [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach{ $0.isActive = true }
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                                 target: self,
                                                 action: #selector(moveToFavorites))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
