//
//  FavoritesViewModel.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 13.02.2024.
//

import Foundation
import UIKit

final class FavoritesViewModel: BaseTableViewModel {
    
    override var news : [Any] {
        didSet {
            reloadTable?()
        }
    }
    
    override func fetchNews() {
        super.fetchNews()
        
        dataStorage?.fetchNews { data in
            switch data {
            case .success(let success):
                let fetchedNews = success.map { FavoriteNews.mapFromEntity($0) }
                DispatchQueue.main.async {
                    self.news = fetchedNews
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    override func getNumberOfRows() -> Int? {
        return news.count
    }
    
    override func getCellModel(at index: Int) -> NewsCellModel? {
        guard index <= news.count else { return nil }
        let news = news[index] as! FavoriteNews
        return NewsCellModel(authors: news.author,
                             date: news.date,
                             title: news.title,
                             description: news.description,
                             imageUrl: nil,
                             link: news.link,
                             isFavorite: news.isFavorite,
                             image: news.uiImage)
    }
    
    override func presentDetails(navController: UINavigationController?, for row: Int) {
        guard let navController, row <= news.count else { return }
        
        let favoriteNews = news[row] as! FavoriteNews
        
        let newsData : NewsProtocol = NewsResult(articleId: favoriteNews.articleId,
                                          title: favoriteNews.title,
                                          link: favoriteNews.link,
                                          creator: [favoriteNews.author],
                                          description: favoriteNews.description,
                                          pubDate: favoriteNews.date,
                                          imageUrl: nil,
                                          sourceUrl: nil,
                                          category: nil)
        
        let viewModel = NewsDetailsViewModel(news: newsData, image: favoriteNews.uiImage)
        
        let vc = NewsDetailsViewController(viewModel: viewModel)
                
        vc.configureView(with: viewModel.news)
        navController.pushViewController(vc, animated: true)
    }
    
}
