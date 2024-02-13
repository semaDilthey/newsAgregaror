//
//  NewsViewController.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import UIKit

final class NewsViewController : BaseViewController {
    
    private let viewModel : NewsViewModel
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchNews()
        
        monitorNews()
    }
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    private func monitorNews() {
        
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func refreshControlActive() {
        DispatchQueue.main.async {
            self.refreshControl.beginRefreshing()
        }
        
        viewModel.fetchNews()
        viewModel.itemsPerFetch = 4
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension NewsViewController {
    
    override func configureView() {
        super.configureView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshControlActive), for: .valueChanged)
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    override func layoutConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension NewsViewController {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollView.contentOffset.y \(scrollView.contentOffset.y)")
        print("scrollView.contentSize.height \(scrollView.contentSize.height)")

        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.5 {
            if viewModel.itemsPerFetch > 10 {
                // Ограничение бесплатной версии newsapi не более 10 объектов
                return
            }
            print("1111")
            viewModel.itemsPerFetch += 2
            viewModel.fetchNews()
        }
        
//        if scrollView.contentOffset.y > scrollView.contentSize.height / 2 {
//            print("1111")
//            viewModel.batchNews(amount: 2)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
}

extension NewsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { return UITableViewCell() }
        if let cellModel = viewModel.getCellModel(at: indexPath.row) {
            cell.configureCell(with: cellModel)
        }
        return cell
    }
    
    
}

extension NewsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.presentDetails(navController: navigationController, for: indexPath.row)
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
