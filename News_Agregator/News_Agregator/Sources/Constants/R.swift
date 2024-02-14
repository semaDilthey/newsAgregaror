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
        
        static var zaglushka = UIImage(named: "заглушка")
        
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
            static var notFavorite = UIImage(named: "notFavorite")
            static var isFavorite = UIImage(named: "isFavorite")
            static var settings = UIImage(named: "setting")
        }
    }
    
    //MARK: -  Strings
    
    enum Strings {
        
        enum Buttons {
            static var back = "Назад"
            static var news = "Новости"
            static var save = "Сохранить"
            static var clean = "Очистить избранное"
        }
        
        enum Labels {
            static var newsPage = "Yellow press"
            static var savedNews = "Saved news"
            static var noNews = "No saved news yet"
        }
        
        
        enum Entity {
            static var newsEntity = "NewsEntity"
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
        
        static var smallOffset : CGFloat = 8
        static var bigOffset : CGFloat = 16
        static var nullOffset : CGFloat = 0
        
        static var smallRadius : CGFloat = 8
        static var bigRadius : CGFloat = 16
        
        static var icon : CGFloat = 30
        
        enum Font {
            static var small : CGFloat = 12
            static var medium : CGFloat = 14
            static var subtitle : CGFloat = 16
            static var title : CGFloat = 18

        }
        
    }
}
