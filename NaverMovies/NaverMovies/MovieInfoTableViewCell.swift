//
//  MovieInfoTableViewCell.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/13.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {

    static let identifier = "MovieInfoTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let temp = MovieInfoView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(temp)
        [
            temp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                         constant: 6),
            temp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                          constant: -6),
            temp.topAnchor.constraint(equalTo: contentView.topAnchor,
                                     constant: 4),
            temp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                        constant: -4)
        ].forEach{ $0.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
