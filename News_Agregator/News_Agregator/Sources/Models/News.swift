//
//  News.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation

struct NewsResponse: Codable {
    let totalResults: Int
    let results: [NewsResult]
    let nextPage: String
}

// MARK: - Result
struct NewsResult: Codable {
    let articleId: String?
    let title: String?
    let link: String?
    let creator: [String]?
    let description: String?
    let pubDate: String?
    let imageUrl: String?
    let sourceUrl: String?
    let category: [String]?

}
