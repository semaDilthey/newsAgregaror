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
    
    private let title = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    private let authortsLabel = UILabel()
    private let image = UIImageView()
    
    public func configureCell(with model: NewsCellModel?) {
        guard let model else { return }
        self.authortsLabel.text = model.authors
        self.title.text = model.title
        self.descriptionLabel.text = "  " + model.description
        self.dateLabel.text = model.date
        
        if let imageUrl = model.imageUrl {
            self.image.kf.setImage(with: URL(string: imageUrl))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.configureCell(with: nil)
    }
}


extension NewsCell {
    
    func configureAppearance() {
        backgroundColor = R.Colors.background
        layer.borderColor = R.Colors.active.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = R.Sizes.smallRadius
        clipsToBounds = true
        
        title.numberOfLines = 2
        title.lineBreakStrategy = .hangulWordPriority
        title.textAlignment = .center
        
        descriptionLabel.numberOfLines = 4
        descriptionLabel.lineBreakStrategy = .standard
        
        image.clipsToBounds = true
        image.layer.cornerRadius = R.Sizes.bigRadius
        image.kf.indicatorType = .activity
    }
    
    func addViews() {
        contentView.addSubview(title)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(authortsLabel)
        contentView.addSubview(image)

//        if let image = image {
//            contentView.addSubview(image)
//        }

    }
    
    func layoutConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        authortsLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        
        let dateAndAuthorStack = getStack(subViews: [dateLabel, authortsLabel], axis: .horizontal, alignment: .fill)
        contentView.addSubview(dateAndAuthorStack)
        
        NSLayoutConstraint.activate([
            dateAndAuthorStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: R.Sizes.smallGap),
            dateAndAuthorStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: R.Sizes.smallGap),
            dateAndAuthorStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -R.Sizes.smallGap),
            
            title.topAnchor.constraint(equalTo: dateAndAuthorStack.bottomAnchor, constant: R.Sizes.bigGap),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: R.Sizes.smallGap),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -R.Sizes.smallGap),
            
            descriptionLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: R.Sizes.smallGap),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: R.Sizes.smallGap),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -R.Sizes.smallGap),
            
            image.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: R.Sizes.smallGap),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
            
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
