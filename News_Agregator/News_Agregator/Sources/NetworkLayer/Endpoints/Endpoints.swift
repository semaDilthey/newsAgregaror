//
//  Endpoints.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation

enum Languages: String {
    case ru = "ru"
    case en = "en"
}

enum Endpoints {
    static let baseUrl = "https://newsdata.io/api/1/news?apikey="
    
    static var apiKey = "pub_380348f4884d3f8246acee0310eae7e49cb27"
    
    static func language(language: Languages) -> String? {
        return "&country=\(language.rawValue)"
    }
    
    static func size(amount: Int) -> String? {
        return "&size=\(amount)"
    }
}


