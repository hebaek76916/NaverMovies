//
//  ViewController.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/13.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieInfoTableViewCell.self,
                           forCellReuseIdentifier: MovieInfoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpLayout()
    }


}

extension ViewController: UITableViewDelegate,
                          UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier,
                                                       for: indexPath) as? MovieInfoTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}

extension ViewController {
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpLayout() {
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}
