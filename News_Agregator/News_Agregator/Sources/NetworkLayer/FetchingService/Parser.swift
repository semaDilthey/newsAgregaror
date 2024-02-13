//
//  Parser.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation

protocol Parsable : AnyObject {
    func decodeJSON <T: Decodable>(ofType: T.Type, from data: Data?, completion: @escaping (Result<T, Error>) -> Void)
}

class Parser : Parsable {
    
    public func decodeJSON <T: Decodable>(ofType: T.Type, from data: Data?, completion: @escaping (Result<T, Error>) -> Void) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let data else {
                completion(.failure(NetworkError.noData))
                print("Ошибка даты")
                return
            }
            
            if let parsedData = try? decoder.decode(ofType.self, from: data) {
                completion(.success(parsedData))
            } else {
                print("Ошибка парсинга")
                completion(.failure(NetworkError.jsonParsingFailed))
            }
            
        }
}
