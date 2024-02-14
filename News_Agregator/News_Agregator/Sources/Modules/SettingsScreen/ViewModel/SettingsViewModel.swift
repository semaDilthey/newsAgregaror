//
//  SettingsViewModel.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 14.02.2024.
//

import Foundation

protocol SettingsProtocol {
    var dataStorage : Persistable { get set }
    
    func getStorageSize() -> Double
    func cleanStorage()
    
}

final class SettingsViewModel: SettingsProtocol {
    
    var dataStorage: Persistable
    
    init(dataStorage: Persistable) {
        self.dataStorage = dataStorage
    }
    
    func getStorageSize() -> Double {
        return 0
    }
    
    func cleanStorage() {
        dataStorage.resetCoreData()
    }
}
