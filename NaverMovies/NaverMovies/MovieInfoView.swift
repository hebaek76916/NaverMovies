//
//  MovieInfoView.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/13.
//

import UIKit

class MovieInfoView: UIView {
    
    private var isStarSelected = false
    private var model: MovieInfo?
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEMP"
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEMP"
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEMP"
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEMP"
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEMP"
        return label
    }()

    private let starMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        addGestureStarMark()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func updateUI(model: MovieInfo) {
        self.model = model
        thumbnailView.setImage(with: model.image)
        titleLabel.text = String(format: "제목 : %@", model.title?.removeHTMLTag() ?? "")
        directorLabel.text = String(format: "감독 : %@", model.director ?? "")
        castLabel.text = String(format: "출연진 : %@", model.actor ?? "")
        scoreLabel.text = String(format: "평점 : %@", model.userRating ?? "")
        setStarMark()
    }
    
    public func reuse() {
        thumbnailView.image = nil
        titleLabel.text = nil
        directorLabel.text = nil
        castLabel.text = nil
        scoreLabel.text = nil
        setStarMark()
    }
}

extension MovieInfoView {
    
    private func addGestureStarMark() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(tabStar))
        starMark.addGestureRecognizer(tap)
    }
    
    private func setStarMark() {
        guard let model = model else { return }
        let favorites = FavoritesManager.shared.getFavoritesData()
        
        if favorites.contains(where: { $0 == model }) {
            starMark.tintColor = .yellow
        } else {
            starMark.tintColor = .gray
        }
    }
    
    @objc func tabStar(_ sender: UITapGestureRecognizer) {
        
        guard let model = self.model else { return }
        
        let savedFavorites = FavoritesManager.shared.getFavoritesData()
        if savedFavorites.contains(where: { $0 == model }) {
            isStarSelected = true
        }

        isStarSelected = !isStarSelected
        
        if isStarSelected {
            starMark.tintColor = .yellow
            FavoritesManager.shared.add(model: model)
            
        } else {
            starMark.tintColor = .gray
            FavoritesManager.shared.minus(model: model)
        }
    }
    
    private func setUpLayout() {
        addSubview(contentView)
        [
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].forEach{ $0.isActive = true }
        
        // Labels Layout
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        [
            titleLabel,
            directorLabel,
            castLabel,
            scoreLabel
        ].forEach{ stackView.addArrangedSubview($0) }
        
        contentView.addSubview(stackView)
        [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].forEach{ $0.isActive = true }
        
        // Thumbnail Image Image View Layout
        contentView.addSubview(thumbnailView)
        [
            thumbnailView.topAnchor.constraint(equalTo: stackView.topAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            thumbnailView.widthAnchor.constraint(equalTo: stackView.heightAnchor,
                                                 multiplier: 1/1.4)
        ].forEach{ $0.isActive = true }
        
        
        stackView.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor,
                                           constant: 10).isActive = true
        // Star Mark Layout
        contentView.addSubview(starMark)
        [
            starMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            starMark.topAnchor.constraint(equalTo: contentView.topAnchor),
            starMark.widthAnchor.constraint(equalToConstant: 32),
            starMark.heightAnchor.constraint(equalToConstant: 32)
        ].forEach{ $0.isActive = true }
        
    }
}
