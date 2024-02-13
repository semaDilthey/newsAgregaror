//
//  NetworkError.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation

enum NetworkError : Error {
    case invalidUrl
    case noData
    case jsonParsingFailed
    case invalidResponse
}
