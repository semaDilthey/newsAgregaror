//
//  FavoritesController.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation
import UIKit

final class FavoritesViewController : TableViewController { 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        followNews()
    }
    
    override func followNews() {
        super.followNews()
        DispatchQueue.main.async {
            self.setupAdvertLabel()
        }
    }
    
    private var advertLabel = UILabel()
    
    private func setupAdvertLabel() {
        viewModel.news.count == 0 ? (advertLabel.isHidden = false) : (advertLabel.isHidden = true)
    }
    
    private func openSettings() {
        
        let viewModel = SettingsViewModel(dataStorage: DataStorage())
        let vcToPresent = SettingsViewController(viewModel: viewModel)
        vcToPresent.delegate = self
        
        if #available(iOS 15.0, *) {
            if let sheet = vcToPresent.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            present(vcToPresent, animated: true)
        }
    }
    
}

extension FavoritesViewController {
    
    override func configureView() {
        super.configureView()
        tableView.bounces = false
        
        advertLabel.text = R.Strings.Labels.noNews
        advertLabel.isHidden = true
        
        addNavBarItem(at: .right(type: .button(image: R.Images.Buttons.settings!)))
        addNavBarItem(at: .left(type: .label), title: R.Strings.Labels.savedNews)
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(advertLabel)
    }
    
    override func layoutConstraints() {
        super.layoutConstraints()
        
        advertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            advertLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            advertLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func navBarRightItemHandler() {
        openSettings()
    }
    
}


extension FavoritesViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        
        let cellModel = viewModel.getCellModel(at: indexPath.row)
        cell.configureCell(with: cellModel)
        return cell
    }
}

extension FavoritesViewController : SettingsDelegate {
    
    func didCleanedStorage() {
        viewModel.news = []
        followNews()
    }
    
}
