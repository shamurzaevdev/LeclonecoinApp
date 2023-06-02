//
//  ArticlesTableViewCell.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import UIKit

/// `ArticlesTableViewCell` is a custom table view cell used to display an article. It includes several labels to display information about the article, an image view to display the article's image, and a currentTask property to handle image loading.
final class ArticlesTableViewCell: UITableViewCell {
    
    enum ArticlesTableViewConstants {
        static let padding: CGFloat = 10
        static let imageViewSize: CGFloat = 150
        static let defaultImage = UIImage(named: "defaultPicture")
    }

    // MARK: - Static property
    
    static let identifier = "ArticlesTableViewCell"
    
    // MARK: - Private properties
    
    private let articleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let urgentLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .red
        label.numberOfLines = 0
        label.text = "URGENT"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let categoryLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .right
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var currentTask: URLSessionDataTask?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentTask?.cancel()
        articleImageView.image = nil
        itemLabel.text = nil
        categoryLabel.text = nil
        priceLabel.text = nil
        dateLabel.text = nil
    }
    
    // MARK: - Public methods
    
    func configure(with article: ArticlesData, category: CategoryData?) {
        itemLabel.text = article.title
        
        categoryLabel.text = category?.name
        urgentLabel.isHidden = !article.isUrgent
        priceLabel.text = String(format: "%.0f€", article.price)
        dateLabel.text = article.creationDate.formattedDate(dateStyle: .short, timeStyle: .short)
        let imageUrl = article.imagesUrl?.small ?? ""
        loadImage(from: imageUrl)
    }
    
    // MARK: Private methods
    
    private func loadImage(from url: String) {
        guard let imageUrlString = URL(string: url) else {
            self.articleImageView.image = ArticlesTableViewConstants.defaultImage
            return
        }
        currentTask = URLSession.shared.dataTask(with: imageUrlString) { data, response, error in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.articleImageView.image = ArticlesTableViewConstants.defaultImage
                }
                return
            }
            DispatchQueue.main.async {
                self.articleImageView.image = image
            }
        }
        currentTask?.resume()
    }
    
    private func setupUI() {
        
        contentView.addSubviews(articleImageView, itemLabel, categoryLabel, priceLabel, urgentLabel, dateLabel)
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                      constant: ArticlesTableViewConstants.padding),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                  constant: ArticlesTableViewConstants.padding),
            articleImageView.heightAnchor.constraint(equalToConstant: ArticlesTableViewConstants.imageViewSize),
            articleImageView.widthAnchor.constraint(equalToConstant: ArticlesTableViewConstants.imageViewSize),
            articleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                     constant: -ArticlesTableViewConstants.padding),
                
            itemLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor,
                                               constant: ArticlesTableViewConstants.padding),
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: ArticlesTableViewConstants.padding),
            itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -ArticlesTableViewConstants.padding),
                
            dateLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor,
                                               constant: ArticlesTableViewConstants.padding),
            dateLabel.topAnchor.constraint(equalTo: itemLabel.bottomAnchor,
                                           constant: ArticlesTableViewConstants.padding),
                
            categoryLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor,
                                                   constant: ArticlesTableViewConstants.padding),
            categoryLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,
                                               constant: ArticlesTableViewConstants.padding),
                
            priceLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor,
                                                constant: ArticlesTableViewConstants.padding),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                               constant: -ArticlesTableViewConstants.padding),

            urgentLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor,
                                                 constant: ArticlesTableViewConstants.padding),
            urgentLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor,
                                                constant: -ArticlesTableViewConstants.padding)
            ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
