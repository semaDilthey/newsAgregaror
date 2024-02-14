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
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let imageView = UIImageView()
    private lazy var link = UILabel()
        
    public func configureView(with news: NewsProtocol) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        authorLabel.text = news.creator?.first
        dateLabel.text = news.pubDate
        link.text = news.link
        
        if let imageUrl = news.imageUrl {
            imageView.kf.setImage(with: URL(string: imageUrl))
        } else if let uiImage = viewModel.image {
            imageView.image = uiImage
        }
    }
    
    override func navBarRightItemHandler() {
        super.navBarRightItemHandler()
        
        if !viewModel.isFavorite {
            viewModel.isFavorite = true
            viewModel.addToFavorites(news: FavoriteNews(articleId: viewModel.news.articleId!,
                                                        author: authorLabel.text ?? "unknown author",
                                                        date: dateLabel.text ?? "no date",
                                                        title: titleLabel.text ?? "no text",
                                                        description: descriptionLabel.text ?? "no text",
                                                        link: link.text ?? "",
                                                        isFavorite: viewModel.isFavorite,
                                                        uiImage: imageView.image ?? UIImage()),
                                     isFavorite: viewModel.isFavorite)
        }
    }
    
    @objc func linkTapped() {
        viewModel.openUrl(link: link.text)
    }
}

extension NewsDetailsViewController {
    
    override func configureView() {
        super.configureView()
        imageView.kf.indicatorType = .activity
        
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakStrategy = .standard
        titleLabel.font = UIFont.R.nunitoSans(size: R.Sizes.Font.medium, weight: .bold)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakStrategy = .standard
        descriptionLabel.font = UIFont.R.nunitoSans(size: R.Sizes.Font.medium, weight: .medium)
        
        authorLabel.font = UIFont.R.nunitoSans(size: R.Sizes.Font.small, weight: .thin)
        dateLabel.font = UIFont.R.nunitoSans(size: R.Sizes.Font.small, weight: .thin)
        link.font = UIFont.R.nunitoSans(size: R.Sizes.Font.medium, weight: .bold)
        link.textColor = R.Colors.active
        link.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
        link.addGestureRecognizer(tapGesture)
        
        addNavBarItem(at: .center, title: viewModel.news.title)
        addNavBarItem(at: .right(type: .button(image: R.Images.Buttons.notFavorite!)))
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(authorLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(link)
    }
    
    override func layoutConstraints() {
        super.layoutConstraints()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        link.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Sizes.bigOffset),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: R.Sizes.bigOffset),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Sizes.bigOffset),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: R.Sizes.bigOffset),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Sizes.nullOffset),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: R.Sizes.nullOffset),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
            authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: R.Sizes.bigOffset),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Sizes.bigOffset),
            
            dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: R.Sizes.bigOffset),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Sizes.bigOffset),
            
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: R.Sizes.bigOffset),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Sizes.bigOffset),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Sizes.bigOffset),
            
            link.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: R.Sizes.bigOffset),
            link.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: R.Sizes.bigOffset),
            link.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -R.Sizes.bigOffset)
        ])

    }
}
