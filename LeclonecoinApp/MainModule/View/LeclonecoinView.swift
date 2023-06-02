//
//  LeclonecoinView.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import UIKit

/// `LeclonecoinView` is a custom UIView that displays an image representing the logo of LeclonecoinApplication.
final class LeclonecoinView: UIView {
    
    enum Constants {
        static let logoImageView = UIImage(named: "leCloneCoinLogo")
    }
    
    // MARK: Private properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Constants.logoImageView
        return imageView
    }()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.frame = bounds
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
