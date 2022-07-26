//
//  APIResponse.swift
//  NewsAPI
//
//  Created by kadir on 21.07.2022.
//

import Foundation

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let author: String?    
}

struct Source: Codable {
    let name: String
}
