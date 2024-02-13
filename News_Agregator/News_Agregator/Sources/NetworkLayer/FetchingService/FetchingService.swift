//
//  FetchingService.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation

protocol FetchingServiceProtocol : AnyObject {
    func getData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

class FetchingService : FetchingServiceProtocol {
    
    let parser: Parsable

    init(parser: Parsable = Parser()) {
        self.parser = parser
    }
    
    func getData<T>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let url = URL(string: urlString) else {
            print(NetworkError.invalidUrl)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? NSError {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
                      completion(.failure(NetworkError.invalidResponse))
                      return
                  }
            
            self.parser.decodeJSON(ofType: T.self, from: data, completion: completion)
            
        }
        task.resume()
    }
    
    
}
