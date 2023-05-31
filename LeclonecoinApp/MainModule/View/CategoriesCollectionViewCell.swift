//
//  CategoriesCollectionViewCell.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import UIKit

/// `CategoriesCollectionViewCell` is a custom collection view cell used to display a category. It includes a label to display the category name and an image view to display the category's image.
final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static properties

    static let identifier = "CategoryCollectionViewCell"
    
    // MARK: - Private prorepties
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryNameLabel)
        
        NSLayoutConstraint.activate([
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
                
            categoryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryNameLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor),
            categoryNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Public methods
    
    func configure(with categoryData: CategoryData) {
        categoryNameLabel.text = categoryData.name
        if let imageName = categoryData.imageName {
            let categoryImage = UIImage(named: imageName)
            categoryImageView.image = categoryImage
        }
    }
}
