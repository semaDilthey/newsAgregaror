//
//  NewsCell.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//
import Kingfisher
import UIKit

final class NewsCell : UITableViewCell {
    
    static let identifier = "NewsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureAppearance()
        addViews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.configureCell(with: nil)
        contentView.clipsToBounds = false
    }
    
    private let title = UILabel()
    private let dateLabel = UILabel()
    private let authortsLabel = UILabel()
    private let image = UIImageView()
    private let favoriteImage = UIImageView()
    
    public func configureCell(with model: NewsCellModel?) {
        guard let model else { return }
        self.authortsLabel.text = model.authors
        self.title.text = model.title
        self.dateLabel.text = Formatter.convertDateFormat(inputDate: model.date ?? "")
        
        if let imageUrl = model.imageUrl {
            self.image.kf.setImage(with: URL(string: imageUrl))
        } else if let uImage = model.image {
            self.image.image = uImage
        } else {
            self.image.image = R.Images.zaglushka
        }
        
        if let _ = model.isFavorite {
            favoriteImage.isHidden = false
        } else {
            favoriteImage.isHidden = true
        }
    }
    
    func setRoundedCorners(at indexPath: IndexPath) {
        if indexPath.row == 0 {
            contentView.clipsToBounds = true
            contentView.layer.cornerRadius = R.Sizes.bigRadius
            contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            contentView.clipsToBounds = false
            contentView.layer.cornerRadius = R.Sizes.nullOffset
        }
    }
}


extension NewsCell {
    
    func configureAppearance() {
        backgroundColor = R.Colors.background
        
        title.numberOfLines = 0
        title.lineBreakStrategy = .hangulWordPriority
        title.textAlignment = .left
        title.font = UIFont.R.nunitoSans(size: R.Sizes.Font.subtitle, weight: .bold)
        
        authortsLabel.font = UIFont.R.nunitoSans(size: R.Sizes.Font.small, weight: .thin)
        
        dateLabel.font = UIFont.R.nunitoSans(size: R.Sizes.Font.small, weight: .thin)
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = R.Images.zaglushka
        image.kf.indicatorType = .activity
        
        favoriteImage.image = R.Images.Buttons.isFavorite

    }
    
    func addViews() {
        contentView.addSubview(title)
        contentView.addSubview(dateLabel)
        contentView.addSubview(authortsLabel)
        contentView.addSubview(image)
        contentView.addSubview(favoriteImage)
    }
    
    func layoutConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        authortsLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        let dateAndAuthorStack = getStack(subViews: [authortsLabel, dateLabel], axis: .horizontal, alignment: .fill)
        dateAndAuthorStack.distribution = .equalSpacing
        authortsLabel.contentHuggingPriority(for: .horizontal)
        contentView.addSubview(dateAndAuthorStack)
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: R.Sizes.bigOffset),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: R.Sizes.bigOffset),
            image.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            dateAndAuthorStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: R.Sizes.bigOffset),
            dateAndAuthorStack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: R.Sizes.bigOffset),
            dateAndAuthorStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -R.Sizes.bigOffset),
                    
            title.topAnchor.constraint(equalTo: authortsLabel.bottomAnchor, constant: R.Sizes.bigOffset),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: R.Sizes.bigOffset),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -R.Sizes.smallOffset),
            
            favoriteImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -R.Sizes.bigOffset),
            favoriteImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -R.Sizes.bigOffset),
            favoriteImage.widthAnchor.constraint(equalToConstant: R.Sizes.icon),
            favoriteImage.heightAnchor.constraint(equalToConstant: R.Sizes.icon)

        ])
    }
    
}


func getStack(subViews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat? = nil, alignment: UIStackView.Alignment) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: subViews)
    stackView.axis = axis
    stackView.spacing = spacing ?? 0
    stackView.alignment = alignment
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
}
