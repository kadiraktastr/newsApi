//
//  NewsRequest.swift
//  NewsAPI
//
//  Created by kadir on 21.07.2022.
//
//keys
//f93c4a259d6e4933b7f8fcd8d0a1cc3d
//67d922c8ed8f424982697d0a001bddc6
//8e79daf8ef7f4b7fb722e3fab3873732
//ba3099113a2a454a8c11b193670b49b5

import Foundation
import Alamofire

final class NewsRequest {
    static let shared = NewsRequest()

    struct Constants {
        static let topHeadlineUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=78b34f5affb74e9c959ba726304c00a8&page="
        static let searchURL = "https://newsapi.org/v2/everything?q="
        static let apiURL = "&sortBy=publishedAt&apiKey=78b34f5affb74e9c959ba726304c00a8&page="
    }
    
    private init() {}
    
    func getTopStories(with page: Int, completion: @escaping (Result<[Article], Error>) -> Void) {
        let urlString = Constants.topHeadlineUrl + "\(page)"
        guard let url = URL(string: urlString) else { return }

        AF.request(url).responseDecodable(of: APIResponse.self, queue: .main,  decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let dataModel):
                completion(.success(dataModel.articles))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
    
    func getSearch(with query:String, page:Int ,completion: @escaping (Result<[Article], Error>) -> Void) {
        let urlString = Constants.searchURL + query + Constants.apiURL + "\(page)"
        guard let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20")) else { return }
        
        AF.request(url).responseDecodable(of: APIResponse.self, queue: .main,  decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let dataModel):
                completion(.success(dataModel.articles))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
    
}
