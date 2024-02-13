//
//  Networking.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation

protocol Networking : AnyObject {
    func getNews(number:Int, completion: @escaping (Result<NewsResponse, Error>) -> Void)
}

final class NetworkManager : Networking {
    
    let fetchingService : FetchingServiceProtocol
    
    init(fetchingService: FetchingService = FetchingService()) {
        self.fetchingService = fetchingService
    }
    
    func getNews(number: Int, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        guard let url = getUrl(with: number, for: .ru) else { return }
        fetchingService.getData(from: url, completion: completion)
    }
}


extension NetworkManager {
    
    private func getUrl(with size: Int, for language: Languages) -> String? {
        guard let size = Endpoints.size(amount: size), let language = Endpoints.language(language: language) else {
            print(NetworkError.invalidUrl)
            return nil
        }
        
        return Endpoints.baseUrl+Endpoints.apiKey+size+language
        
    }
}
