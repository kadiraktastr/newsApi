//
//  MainViewModel.swift
//  NewsAPI
//
//  Created by kadir on 26.07.2022.
//

import Foundation


struct MainState {

    enum Change: StateChange {
        case reloadTableView
    }

}

class MainViewModel: StatefulViewModel<MainState.Change> {
    
    private(set) var state: MainState

    init(state: MainState) {
        self.state = state
        super.init()
    }
    
    private(set) var dataModel: [NewsPresentation] = []
    var newsData: [NewsPresentation] = []
    
    var currentPage = 1
    var currentSearchPage = 1
    var testquery: String = ""
    
    func fetchData() {
        NewsRequest.shared.getTopStories(with: currentPage) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.newsData = articles.compactMap({
                    NewsPresentation(
                        title: $0.title,
                        subTitle: $0.description ?? "No Description",
                        imageURL: URL(string:$0.urlToImage ?? ""),
                        publishedAt: $0.publishedAt,
                        content: $0.content,
                        author: $0.author,
                        url: $0.url
                    )
                })
                
                if self?.currentPage == 1 {
                    self?.dataModel = articles.compactMap({
                        NewsPresentation(
                            title: $0.title,
                            subTitle: $0.description ?? "No Description",
                            imageURL: URL(string:$0.urlToImage ?? ""),
                            publishedAt: $0.publishedAt,
                            content: $0.content,
                            author: $0.author,
                            url: $0.url
                        )
                    })
                } else {
                    self?.dataModel.append(contentsOf: self?.newsData ?? [])
                }
            
                DispatchQueue.main.async {
                    self?.emit(change: .reloadTableView)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchData() {
        NewsRequest.shared.getSearch(with: self.testquery , page: currentSearchPage) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.newsData = articles.compactMap({
                    NewsPresentation(
                        title: $0.title,
                        subTitle: $0.description ?? "No Description",
                        imageURL: URL(string:$0.urlToImage ?? ""),
                        publishedAt: $0.publishedAt,
                        content: $0.content,
                        author: $0.author,
                        url: $0.url
                    )
                })
                
                if self?.currentSearchPage == 1 {
                    self?.dataModel = articles.compactMap({
                        NewsPresentation(
                            title: $0.title,
                            subTitle: $0.description ?? "No Description",
                            imageURL: URL(string:$0.urlToImage ?? ""),
                            publishedAt: $0.publishedAt,
                            content: $0.content,
                            author: $0.author,
                            url: $0.url
                        )
                    })
                } else {
                    self?.dataModel.append(contentsOf: self?.newsData ?? [])
                    
                }
                
                DispatchQueue.main.async {
                    self?.emit(change: .reloadTableView)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
