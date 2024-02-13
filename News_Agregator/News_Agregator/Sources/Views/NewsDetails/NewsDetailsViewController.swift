//
//  NewsDetailsViewController.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//
import Kingfisher
import Foundation
import UIKit

final class NewsDetailsViewController : BaseViewController {
    
    private let viewModel : NewsDetailsViewModel
    
    init(viewModel: NewsDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let author = UILabel()
    private let date = UILabel()
    private let imageView = UIImageView()
    private let link = UILabel()
    
    public func configureView(with news: NewsResult) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        author.text = news.creator?.first
        date.text = news.pubDate
        link.text = news.link
        
        if let imageUrl = news.imageUrl {
            imageView.kf.setImage(with: URL(string: imageUrl))
        }
    }
    
    override func navBarRightItemHandler() {
        super.navBarRightItemHandler()
        
        
    }
}

extension NewsDetailsViewController {
    
    override func configureView() {
        super.configureView()
        imageView.kf.indicatorType = .activity
        
        addNavBarItem(at: .center, title: viewModel.news.title)
        addNavBarItem(at: .right(type: .button))
    }
    
    override func addSubviews() {
        super.addSubviews()
    }
    
    override func layoutConstraints() {
        super.layoutConstraints()
    }
}
