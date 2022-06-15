//
//  MovieInfoView.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/13.
//

import UIKit

class MovieInfoView: UIView {

    private let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func updateUI(model: MovieInfo) {
        //thumbnail
        titleLabel.text = String(format: "제목 : %@", model.title?.removeHTMLTag() ?? "")
        directorLabel.text = String(format: "감독 : %@", model.director ?? "")
        castLabel.text = String(format: "출연진 : %@", model.actor ?? "")
        scoreLabel.text = String(format: "평점 : %@", model.userRating ?? "")
    }
}

extension MovieInfoView {
    
    private func setUpLayout() {
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
        
        addSubview(stackView)
        [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].forEach{ $0.isActive = true }
        
        // Thumbnail Image Image View Layout
        addSubview(thumbnailView)
        [
            thumbnailView.topAnchor.constraint(equalTo: stackView.topAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            thumbnailView.widthAnchor.constraint(equalTo: heightAnchor,
                                                 multiplier: 1/1.4)
        ].forEach{ $0.isActive = true }
        
        
        stackView.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor,
                                           constant: 10).isActive = true
        // Star Mark Layout
        starMark.backgroundColor = .yellow
        addSubview(starMark)
        [
            starMark.trailingAnchor.constraint(equalTo: trailingAnchor),
            starMark.topAnchor.constraint(equalTo: topAnchor),
            starMark.widthAnchor.constraint(equalToConstant: 32),
            starMark.heightAnchor.constraint(equalToConstant: 32)
        ].forEach{ $0.isActive = true }
        
    }
    
}

extension String {

   func removeHTMLTag() -> String {

       return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)

    }

}
