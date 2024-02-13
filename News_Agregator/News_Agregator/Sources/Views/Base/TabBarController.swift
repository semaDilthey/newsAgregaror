//
//  TabBarController.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

enum Tabs : Int, CaseIterable {
    case news
    case favorites
}

import UIKit

class TabBarController : UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabBarController {
    
    private func configureAppearance() {
        tabBar.tintColor = R.Colors.active
        tabBar.barTintColor = R.Colors.inActive
        tabBar.backgroundColor = R.Colors.white

        tabBar.layer.borderColor = R.Colors.white.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let controllers : [BaseNavController] = Tabs.allCases.map { tab in
            let image = R.Images.TabBar.image(for: tab)
            let image1 = imageWithImg(with: image, scaledTo: CGSize(width: 25, height: 25))
            let controller = BaseNavController(rootViewController: getController(for: tab))
            controller.tabBarItem = UITabBarItem(title: R.Strings.TabBar.title(for: tab),
                                                 image: image1,
                                                 tag: tab.rawValue)
            
            return controller
        }
        
        setViewControllers(controllers, animated: true)
    }
    
    func imageWithImg(with image: UIImage?, scaledTo newSize: CGSize) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            image?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
    
    private func getController(for tab: Tabs) -> BaseViewController {
        switch tab {
        case .news: return NewsViewController(viewModel: NewsViewModel())
        case .favorites: return FavoritesViewController()
        }
    }
}
