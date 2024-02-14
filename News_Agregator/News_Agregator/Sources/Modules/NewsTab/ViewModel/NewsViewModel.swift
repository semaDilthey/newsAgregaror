//
//  NewsViewModel.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import UIKit

final class NewsViewModel: BaseTableViewModel {
    
    override var news : [Any] {
        didSet {
            reloadTable?()
        }
    }
    
//    var itemsPerFetch = 4
    
    override func fetchNews() {
        super.fetchNews()
        
        networking?.getNews(number: itemsPerFetch) { response in
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
        networking?.getNews(number: amount) { response in
            switch response {
            case .success(let success):
                DispatchQueue.main.async {
                    let batchedNews = success.results
                    #warning("К добавлению только те новости, которые не существуют в нашем массиве. Пока работает неважно. Если успею - доделю")
                    let newsToAppend = batchedNews.filter { batchedItem in
                        batchedNews.contains { $0.articleId == batchedItem.articleId }
                    }
                    self.news += newsToAppend
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    override func getCellModel(at indexPath: Int) -> NewsCellModel? {
        super.getCellModel(at: indexPath)
        guard indexPath <= news.count else { return nil }
        let news = news[indexPath] as! NewsResult
        return NewsCellModel(authors: news.creator?.first ?? "Автор неизвестен",
                             date: news.pubDate ?? "сейчас",
                             title: news.title ?? "",
                             description: news.description ?? "Без текста",
                             imageUrl: news.imageUrl,
                             link: news.link ?? "No link")
       }
    
    //MARK:  TableView DataSource
    override func getNumberOfRows() -> Int? {
        super.getNumberOfRows()
        return news.count
    }
}


