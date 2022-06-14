//
//  MovieResultModel.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/14.
//

import Foundation

// MARK: - Movie Result
struct MovieResult: Codable {
    let lastBuildDate: String?
    let total, start, display: Int?
    let items: [MovieInfo]?
}

// MARK: - Movie Info
struct MovieInfo: Codable {
    let title: String?
    let link: String?
    let image: String?
    let subtitle, pubDate, director, actor: String?
    let userRating: String?
}
