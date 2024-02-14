//
//  DataStorage.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 13.02.2024.
//

import Foundation
import CoreData

protocol Persistable {
    var news : [NewsEntity]? { get set }
    var newsUpdated : (()->())? { get set }
    
    mutating func saveNews(_ news: NewsEntity)
    mutating func fetchNews(completion: @escaping (Result<[NewsEntity], Error>)-> Void)
    mutating func updateNews(_ news: NewsEntity, at index: Int)
    mutating func deleteNews(at index: Int)
    mutating func resetCoreData()
    
    mutating func addToFavorites(_ news: NewsEntity, isFavorite: Bool)
}

struct DataStorage : Persistable {
    
    var storageManager : CoreDataManager
    
    init(storageManager: CoreDataManager = CoreDataManager.shared) {
        self.storageManager = storageManager
    }
    
    var news : [NewsEntity]? {
        didSet {
            newsUpdated?()
        }
    }
    
    var newsUpdated : (()->())?
    
    mutating func saveNews(_ news: NewsEntity) {
        guard let noteEntityDescription = NSEntityDescription.entity(forEntityName: R.Strings.Entity.newsEntity,
                                                                           in: storageManager.mainContext) else { return }
        var newsEntity = NewsEntity(entity: noteEntityDescription, insertInto: storageManager.mainContext)
        newsEntity = news
        
        do {
            try storageManager.mainContext.save()
            self.news?.append(newsEntity)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    mutating func fetchNews(completion: @escaping (Result<[NewsEntity], Error>)-> Void) {
        
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        let sortDescriptorByDate = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptorByDate]
        
        do {
            let noteEntities = try storageManager.mainContext.fetch(fetchRequest)
            let filteredEntites = noteEntities.filter { $0.title != nil && $0.date != nil }
            
            self.news = filteredEntites
            completion(.success(filteredEntites))
        } catch {
            completion(.failure(error))
        }
    }
    
    
    mutating func updateNews(_ news: NewsEntity, at index: Int) {
//        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        do {
//            let noteEntities = try storageManager.mainContext.fetch(fetchRequest)
//            var filteredEntity = noteEntities.filter { $0.date == news.date }.first
//            
//            self.news?.insert(news, at: index+1)
//            self.news?.remove(at: index)
//            filteredEntity = news
//
//            try storageManager.mainContext.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
    }
    
    mutating func addToFavorites(_ note: NewsEntity, isFavorite: Bool) {
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()

        do {
            let noteEntities = try storageManager.mainContext.fetch(fetchRequest)
            var filteredEntity = noteEntities.filter { $0.date == note.date }.first
            
            filteredEntity?.isFavorite = isFavorite
            if let index = news?.firstIndex(where: { $0.articleId == note.articleId }) {
                news?[index].isFavorite = note.isFavorite
            }
            try storageManager.mainContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    mutating func deleteNews(at index: Int) {
    
        do {
            let noteToDeletion = news?[index]
            guard let noteToDeletion else { return }
            storageManager.mainContext.delete(noteToDeletion)
            if index > 0 {
                news?.remove(at: index)
            } else {
                news?.remove(at: 0)
            }
        }
        storageManager.saveContext()
    }
    
    mutating func resetCoreData() {
        storageManager.resetAllCoreData()
        self.news = nil
    }
}

extension DataStorage {
    
    private func findNoteEntity(withIndex index: Int, in context: NSManagedObjectContext) -> NewsEntity? {
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "index == %d", index)

        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Error finding note entity: \(error)")
            return nil
        }
    }
    
}
