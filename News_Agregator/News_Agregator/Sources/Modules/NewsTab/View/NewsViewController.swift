//
//  NewsViewController.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import UIKit

final class NewsViewController : TableViewController { }

extension NewsViewController {
    
    override func configureView() {
        super.configureView()
        
        addNavBarItem(at: .left(type: .label), title: R.Strings.Labels.newsPage)
    }
}


extension NewsViewController {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if scrollView.contentOffset.y > scrollView.contentSize.height / 10 {
            if viewModel.itemsPerFetch > 10 {
                // Ограничение бесплатной версии newsapi не более 10 объектов
                return
            }
            viewModel.itemsPerFetch += 2
            viewModel.fetchNews()
        }
        
        #warning("Для грамотной пагинации надо настроить batchNews, если успею")
//        if scrollView.contentOffset.y > scrollView.contentSize.height / 2 {
//            print("1111")
//            viewModel.batchNews(amount: 2)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
}

extension NewsViewController  {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { return UITableViewCell() }
        cell.setRoundedCorners(at: indexPath)
        if let cellModel = viewModel.getCellModel(at: indexPath.row) {
            cell.configureCell(with: cellModel)
        }
        return cell
    }
}
