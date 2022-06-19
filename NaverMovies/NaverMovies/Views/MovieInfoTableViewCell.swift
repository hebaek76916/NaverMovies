//
//  MovieInfoTableViewCell.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/13.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {

    static let identifier = "MovieInfoTableViewCell"
    
    private var infoView: MovieInfoView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        infoView = MovieInfoView()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        infoView?.reuse()
    }
    
    public func updateUI(model: MovieInfo) {
        infoView?.updateUI(model: model)
    }
    
}

extension MovieInfoTableViewCell {
    private func setUpUI() {
        guard let infoView = self.infoView else {
            return
        }
        infoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoView)
        [
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                         constant: 6),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                          constant: -6),
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                     constant: 4),
            infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                        constant: -4)
        ].forEach{ $0.isActive = true }
    }
}
