//
//  DetailsView.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import UIKit

struct DetailsViewConstants {
    static let padding: CGFloat = 20
    static let imageViewSize: CGFloat = 250
    static let halfPadding: CGFloat = 10
}


/// `DetailsView` is a custom UIView that displays detailed information about a particular item. This view includes a scroll view containing multiple labels for displaying different attributes of the item, such as the title, image, description, category, price, urgency, siret number, and creation date.
final class DetailsView: UIView {

    // MARK: - Properties
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
    }()
        
    var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
        
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
        
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
        
    var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        return label
    }()
        
    var urgentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .red
        label.text = "URGENT"
        return label
    }()
        
    var siretLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    var creationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Private Properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
        
    // MARK: - Initialization
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private Methods
        
    private func setupUI() {
        backgroundColor = .systemBackground
        
        setupScrollView()
        setupContentView()
        setupSubViews()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupSubViews() {
        
        let subviews = [titleLabel, imageView, descriptionLabel, categoryLabel,
                        priceLabel, urgentLabel, siretLabel, creationLabel]
        
        contentView.addSubviews(titleLabel, imageView, descriptionLabel, categoryLabel,
                                priceLabel, urgentLabel, siretLabel, creationLabel)
        
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DetailsViewConstants.padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DetailsViewConstants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DetailsViewConstants.padding),
                    
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DetailsViewConstants.padding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: DetailsViewConstants.imageViewSize),
                        
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: DetailsViewConstants.padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DetailsViewConstants.padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DetailsViewConstants.padding),
                        
            categoryLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: DetailsViewConstants.padding),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DetailsViewConstants.padding),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DetailsViewConstants.padding),
                    
            creationLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: DetailsViewConstants.padding),
            creationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DetailsViewConstants.padding),
                        
            priceLabel.topAnchor.constraint(equalTo: creationLabel.bottomAnchor, constant: DetailsViewConstants.padding),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DetailsViewConstants.padding),
                        
            urgentLabel.topAnchor.constraint(equalTo: creationLabel.bottomAnchor, constant: DetailsViewConstants.padding),
            urgentLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: DetailsViewConstants.halfPadding),
                        
            siretLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: DetailsViewConstants.padding),
            siretLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DetailsViewConstants.padding),
            siretLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DetailsViewConstants.padding),
            siretLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DetailsViewConstants.padding)
        ])
    }
}
