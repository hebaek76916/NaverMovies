//
//  MovieWebViewController.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/18.
//

import UIKit
import WebKit

class MovieWebViewController: UIViewController {
    
    private let model: MovieInfo
    private let webView = WKWebView()

    private let infoView: MovieInfoView = {
        let view = MovieInfoView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(model: MovieInfo) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = model.title?.removeHTMLTag() ?? ""
        setUpUI()
        setWebView()
    }
    
    private func setWebView() {
        guard let urlString = model.link else { return }
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(infoView)
        infoView.updateUI(model: model)
        [
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //infoView.heightAnchor.constraint(equalToConstant: 120)
        ].forEach { $0.isActive = true }
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        [
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: infoView.bottomAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach{ $0.isActive = true }
    }
}
