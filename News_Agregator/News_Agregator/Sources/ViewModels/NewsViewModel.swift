//
//  NewsViewModel.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import UIKit

final class NewsViewModel {
    
    let networking : Networking
    
    init(networking: Networking = NetworkManager()) {
        self.networking = networking
    }
    
    var reloadTable : (()->())?
    
    var news : [NewsResult] = [] {
        didSet {
            reloadTable?()
        }
    }
    
    var itemsPerFetch = 4
    
    func fetchNews() {
        networking.getNews(number: itemsPerFetch) { response in
            switch response {
            case .success(let success):
                print("Updated")
                DispatchQueue.main.async {
                    self.news = success.results
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func batchNews(amount: Int) {
        itemsPerFetch += amount
        if itemsPerFetch > 10 {
            // Ограничение бесплатной версии newsapi не более 10 объектов
            return
        }
        networking.getNews(number: amount) { response in
            switch response {
            case .success(let success):
                DispatchQueue.main.async {
                    let batchedNews = success.results
                    #warning("К добавлению только те новости, которые не существуют в нашем массиве. Пока работает через жепу")
                    let newsToAppend = batchedNews.filter { batchedItem in
                        batchedNews.contains { $0.articleId == batchedItem.articleId }
                    }
                    print(newsToAppend)
                    self.news += newsToAppend
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getCellModel(at indexPath: Int) -> NewsCellModel? {
        guard indexPath <= news.count else { return nil }
        let news = news[indexPath]
        return NewsCellModel(authors: news.creator?.first ?? "Автор неизвестен",
                             date: news.pubDate ?? "сейчас",
                             title: news.title ?? "",
                             description: news.description ?? "Без текста",
                             imageUrl: news.imageUrl,
                             link: news.link ?? "No link")
       }
    
    func presentDetails(navController: UINavigationController?, for row: Int) {
        guard let navController, row <= news.count else { return }
        let news = news[row]
        let viewModel = NewsDetailsViewModel(news: news)
        print(viewModel.news.title)
        let vc = NewsDetailsViewController(viewModel: viewModel)
        navController.pushViewController(vc, animated: true)
        
    }
}

//MARK: - TableView DataSource
extension NewsViewModel {
    
    func getNumberOfRows() -> Int {
        return news.count
    }
    
}
