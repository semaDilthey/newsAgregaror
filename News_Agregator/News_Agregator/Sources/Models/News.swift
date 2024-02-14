//
//  News.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation
import UIKit

protocol NewsProtocol {
    var articleId: String? { get }
    var title: String? { get }
    var link: String? { get }
    var creator: [String]? { get }
    var description: String? { get }
    var pubDate: String? { get }
    var imageUrl: String? { get }
    
    var isFavorite: Bool? { get set }
}

struct NewsResponse: Codable {
    let totalResults: Int
    let results: [NewsResult]
    let nextPage: String
}

// MARK: - Result
struct NewsResult: Codable, NewsProtocol {
    let articleId: String?
    let title: String?
    let link: String?
    let creator: [String]?
    let description: String?
    let pubDate: String?
    let imageUrl: String?
    let sourceUrl: String?
    let category: [String]?
    
    var isFavorite: Bool? = false

}
