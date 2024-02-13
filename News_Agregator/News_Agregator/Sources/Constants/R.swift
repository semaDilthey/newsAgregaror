//
//  R.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation
import UIKit

enum R {
    
    //MARK: - Colors
    
    enum Colors : CaseIterable {
        
        static var background = UIColor(hexString: "#F2F2F6")
        static var active = UIColor(hexString: "#FD3A69")
        static var inActive = UIColor(hexString: "#FFFFFF")
        static var black = UIColor(hexString: "#1C2121")
        static var white = UIColor(hexString: "#FFFFFF")
        static var grey = UIColor(hexString: "#CECBD3")
        
    }
    
    //MARK: - Images
    
    enum Images {
        
        enum TabBar {
            static func image(for tab: Tabs) -> UIImage? {
                switch tab {
                case .news:
                    UIImage(named: "news")
                case .favorites:
                    UIImage(named: "favorites")
                }
            }
        }
        
        enum Buttons {
            static var plusIcon = UIImage(named: "plusIcon")
            static var saveIcon = UIImage(named: "diskette")
            static var notFavorite = UIImage(named: "notFavorite")
            static var isFavorite = UIImage(named: "isFavorite")
        }
    }
    
    //MARK: -  Strings
    
    enum Strings {
        
        enum Titles {
            
            static var creatingNote = "Создание заметки"
        }
        
        enum Buttons {
            static var back = "Назад"
            static var notes = "Заметки"
            static var save = "Сохранить"
            static var add = "Добавить"
        }
        
        enum Labels {
            static var myNotes = "Мои записки"
            static var noNotes = "Нет записок"
        }
        
        
        enum Entity {
            static var newsEntity = "newsEntity"
        }
        
        enum TabBar {
            static func title(for tab: Tabs) -> String? {
                switch tab {
                case .news:
                    "News"
                case .favorites:
                    "Favorites"
                }
            }
        }

    }
    
    //MARK: - Sizes
    
    enum Sizes {
        
        static var smallGap : CGFloat = 8
        static var bigGap : CGFloat = 16
        
        static var smallRadius : CGFloat = 8
        static var bigRadius : CGFloat = 16
        
    }

    
}
