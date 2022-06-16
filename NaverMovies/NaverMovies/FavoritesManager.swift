//
//  FavoritesManager.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/15.
//

import Foundation

class FavoritesManager {
    
    static var shared = FavoritesManager()
    
    private var favorites: [String: MovieInfo] = [:] {
        didSet {
            UserDefaults.standard.set(try? PropertyListEncoder()
                                        .encode(favorites),
                                      forKey: "favorites")
        }
    }
    
    init() {
        if let data = UserDefaults.standard.value(forKey: "favorites") as? Data {
            let favorites = try? PropertyListDecoder().decode([String: MovieInfo].self,
                                                              from: data)
            self.favorites = favorites ?? [:]
        }

    }
    
    public func getFavoritesData() -> [MovieInfo] {
        return self.favorites.values.map{ $0 }
    }
    
    public func add(model: MovieInfo) {
        guard let linkString = model.link else { return }
        favorites[linkString] = model
    }

    public func minus(model: MovieInfo) {
        guard let linkString = model.link else { return }
        favorites.removeValue(forKey: linkString)
    }
    
}
