//
//  FavoriteManager.swift
//  NewsAPI
//
//  Created by kadir on 23.07.2022.
//

import Foundation

class FavoriteManager {
    static var shared = FavoriteManager()
    
    private(set) var favNews: [NewsPresentation] = []
    init() { }

    func isFavorite(_ news: NewsPresentation) -> Bool {
        return favNews.contains(where: {$0 == news })
    }

    func deleteNews(_ news: NewsPresentation) {
        guard let index =  favNews.firstIndex(of: news) else { return }
        favNews.remove(at: index)
    }

    func addFavorite(_ news: NewsPresentation) {
        favNews.append(news)
    }

}
