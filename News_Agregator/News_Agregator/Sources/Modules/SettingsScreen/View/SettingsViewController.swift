//
//  SettingsViewController.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 14.02.2024.
//

import Foundation
import UIKit

protocol SettingsDelegate : AnyObject {
    func didCleanedStorage()
}

final class SettingsViewController : BaseViewController {
    
    weak var delegate : SettingsDelegate?
    
    private let viewModel: SettingsProtocol
    
    init(viewModel: SettingsProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cleanButton : UIButton = {
        let button = UIButton()
        button.setTitle(R.Strings.Buttons.clean, for: .normal)
        button.animateTouch(button)
        return button
    }()
    
    @objc func buttonTapped() {
        viewModel.cleanStorage()
        delegate?.didCleanedStorage()
    }
}

extension SettingsViewController {
    
    override func configureView() {
        super.configureView()
        
        cleanButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func addSubviews() {
        view.addSubview(cleanButton)
    }
    
    override func layoutConstraints() {
        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cleanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cleanButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

    }
}
