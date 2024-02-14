//
//  BaseTableViewModel.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 13.02.2024.
//

import Foundation
import UIKit

protocol BaseTableViewModelProtocol {
    var reloadTable : (()->())? { get }
    
    var networking : Networking? { get set }
    var dataStorage: Persistable? { get set }
    var news : [Any] { get set }
    
    var itemsPerFetch : Int { get set }
    func fetchNews()
    func getNumberOfRows() -> Int?
    func getCellModel(at index: Int) -> NewsCellModel?
    func presentDetails(navController: UINavigationController?, for row: Int)
}

class BaseTableViewModel : BaseTableViewModelProtocol {
    
    var news: [Any] = []
    
    func fetchNews() {}
    
    var networking: Networking?
    var dataStorage: Persistable?
    
    init(networking: Networking? = NetworkManager(), dataStorage: Persistable? = DataStorage()) {
        self.networking = networking
        self.dataStorage = dataStorage
    }
        
    var itemsPerFetch: Int = 4
    var reloadTable: (() -> ())?
    
    func getNumberOfRows() -> Int? {
        return nil
    }
    
    func getCellModel(at index: Int) -> NewsCellModel? {
        return nil
    }
    
    func presentDetails(navController: UINavigationController?, for row: Int) {
        guard let navController, row <= news.count else { return }
        let news = news[row]
        let viewModel = NewsDetailsViewModel(news: news as! NewsProtocol)
        let vc = NewsDetailsViewController(viewModel: viewModel)
        vc.configureView(with: news as! NewsResult)
        navController.pushViewController(vc, animated: true)
    }

}

