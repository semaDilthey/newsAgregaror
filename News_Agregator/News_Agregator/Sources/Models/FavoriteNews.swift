//
//  FavoriteNews.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 13.02.2024.
//

import Foundation
import CoreData
import UIKit

protocol EntityModelMapProtocol {
    typealias EntityType = NewsEntity
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType
    static func mapFromEntity(_ entity: EntityType) -> FavoriteNews
}

protocol FavoriteNewsProtocol {
    var uiImage: UIImage? { get set }
}

struct FavoriteNews: FavoriteNewsProtocol {
    
    let articleId: String
    let author: String
    let date: String
    let title: String
    let description: String
    let link: String
    var isFavorite: Bool
    
    var uiImage: UIImage?
}

extension FavoriteNews : EntityModelMapProtocol {
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let news = EntityType(context: context)
        news.articleId = self.articleId
        news.author = self.author
        news.date = self.date
        news.descriptionn = self.description
        news.link = self.link
        news.title = self.title
        news.isFavorite = self.isFavorite
        news.image = self.uiImage?.jpegData(compressionQuality: 1.0)
        return news
    }
    
    static func mapFromEntity(_ entity: EntityType) -> FavoriteNews {

        let favoriteNews = FavoriteNews(articleId: entity.articleId ?? "wrong id",
                                        author: entity.author ?? "Автор неизвестен",
                                        date: entity.date ?? "Без даты",
                                        title: entity.title ?? "Без титла",
                                        description: entity.descriptionn ?? "",
                                        link: entity.link ?? "no link provided",
                                        isFavorite: entity.isFavorite,
                                        uiImage: UIImage(data: entity.image ?? Data()) ?? UIImage())
        return favoriteNews
    }
    
    
}
