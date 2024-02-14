//
//  BaseViewController.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        addSubviews()
        layoutConstraints()
    }

    private lazy var leftButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private lazy var rightButton : FavButton = {
        let button = FavButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont.R.nunitoSans(size: R.Sizes.Font.title+2, weight: .bold)
        title.textColor = R.Colors.black
        return title
    } ()

}

@objc extension BaseViewController {
    
    func configureView() {
        view.backgroundColor = R.Colors.background
        navigationController?.navigationBar.tintColor = R.Colors.active
    }
    
    func layoutConstraints() {}
    func addSubviews() {}
    
    func navBarLeftItemHandler() {
        print("Left selector was tapped")
    }
    
    func navBarRightItemHandler() {
        print("Rigth selector was tapped")
        
        if !rightButton.isSelected {
            rightButton.isSelected = true
            rightButton.image.image = R.Images.Buttons.notFavorite
        } else {
            rightButton.isSelected = false
            rightButton.image.image = R.Images.Buttons.isFavorite
        }
    }
    
}

enum NavBarPosition {
    case left(type: NavBarItemType)
    case right(type: NavBarItemType)
    case center
}

enum NavBarItemType {
    case button(image: UIImage)
    case label
}

extension BaseViewController {
    
    func addNavBarItem(at position: NavBarPosition, title : String? = nil) {

        switch position {
        case .left(let type):
            
            switch type {
            case .button:
                leftButton.addTarget(self, action: #selector(navBarLeftItemHandler), for: .touchUpInside)
                leftButton.setTitle(title, for: .normal)
                leftButton.animateTouch(leftButton)
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
            case .label:
                titleLabel.text = title
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
            }
            
        case .right(let type):
            switch type {
            case .button(let image):
                rightButton.addTarget(self, action: #selector(navBarRightItemHandler), for: .touchUpInside)
                rightButton.animateTouch(rightButton)
                rightButton.image.image = image
                rightButton.isSelected = true
                rightButton.widthAnchor.constraint(equalToConstant: R.Sizes.icon).isActive = true
                rightButton.heightAnchor.constraint(equalToConstant: R.Sizes.icon).isActive = true
                navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
            case .label:
                titleLabel.text = title
                navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
            }
            
        case .center:
            navigationItem.title = title
        }
    }
}

class FavButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        addViews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var image = UIImageView()
    
}


extension FavButton {
    
    private func configureAppearance() {
        
    }
    
    private func addViews() {
        addSubview(image)
    }
    
    private func layoutConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            image.widthAnchor.constraint(equalToConstant: R.Sizes.icon),
            image.heightAnchor.constraint(equalToConstant: R.Sizes.icon)

        ])
    }
}
