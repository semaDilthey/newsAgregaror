//
//  NewsDetailsViewModel.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation
import UIKit

final class NewsDetailsViewModel {
    
    let news : NewsProtocol
    var dataStorage : Persistable
    let image : UIImage?
    var isFavorite: Bool = false
    
    init(news: NewsProtocol, dataStorage: Persistable = DataStorage(), image: UIImage? = nil) {
        self.news = news
        self.dataStorage = dataStorage
        self.image = image
    }
    
    func addToFavorites(news: FavoriteNews, isFavorite: Bool) {
        let newsToSave = news.mapToEntityInContext(CoreDataManager.shared.mainContext)
        dataStorage.saveNews(newsToSave)
        dataStorage.addToFavorites(newsToSave, isFavorite: isFavorite)
    }

    
    func openUrl(link: String?) {
        guard let link else { return }
        guard let url = URL(string: link) else {
            print("Wrong url")
            return
        }
        UIApplication.shared.open(url)
    }
}
