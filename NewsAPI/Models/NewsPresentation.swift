//
//  NewsPresentation.swift
//  NewsAPI
//
//  Created by kadir on 24.07.2022.
//

import Foundation

class NewsPresentation: Equatable {
    
    static func == (lhs: NewsPresentation, rhs: NewsPresentation) -> Bool {
        lhs.title == rhs.title
    }

    var title: String
    var subTitle: String
    var imageURL: URL?
    var imageData: Data? = nil
    var publishedAt: String?
    var content: String?
    var author: String?
    var url: String?
    
    var isFavorite: Bool {
        return FavoriteManager.shared.isFavorite(self)
    }
 
    init(
        title: String,
        subTitle: String,
        imageURL: URL?,
        publishedAt: String?,
        content: String?,
        author: String?,
        url: String?
    ) {
        self.title = title
        self.subTitle = title
        self.imageURL = imageURL
        self.publishedAt = publishedAt
        self.content = content
        self.author = author
        self.url = url
    }
    
}
