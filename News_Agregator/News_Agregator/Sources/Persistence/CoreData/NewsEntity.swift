//
//  NewsEntity+CoreDataProperties.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 13.02.2024.
//
//

import Foundation
import CoreData

@objc(NewsEntity)
public class NewsEntity: NSManagedObject {

}

extension NewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptionn: String?
    @NSManaged public var articleId: String?
    @NSManaged public var link: String?
    @NSManaged public var isFavorite: Bool

    @NSManaged public var image: Data?

}

extension NewsEntity : Identifiable {

}
