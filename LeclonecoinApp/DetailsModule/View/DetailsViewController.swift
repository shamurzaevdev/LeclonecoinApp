//
//  DetailsViewController.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import UIKit

/// `DetailsViewController` is a custom UIViewController that manages the presentation of detailed information about a particular item in a `DetailsView`.
final class DetailsViewController: UIViewController {
    // MARK: - Private Properties
    
    private let detailsView = DetailsView()
    
    // MARK: - Properties
    
    var viewModel: DetailsViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupImage()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        let viewData = viewModel.detailsData
        detailsView.titleLabel.text = viewData.title
        detailsView.descriptionLabel.text = viewData.description
        detailsView.categoryLabel.text = viewData.category
        detailsView.priceLabel.text = String(format: "%.0f€", viewData.price)
        detailsView.urgentLabel.isHidden = !viewData.isUrgent
        detailsView.creationLabel.text = viewData.creationDate
        if let siret = viewData.siret {
            detailsView.siretLabel.text = "Siret: \(siret)"
            detailsView.siretLabel.isHidden = false
        } else {
            detailsView.siretLabel.isHidden = true
        }
        
    }
    
    private func setupImage() {
        if let imageURLString = viewModel.detailsData.imagesUrl?.thumb {
            print("Loading image from URL: \(imageURLString)")
            viewModel.loadImage(from: imageURLString) { [weak self] image in
                self?.detailsView.imageView.image = image
            }
        } else {
        detailsView.imageView.image = UIImage(named: "defaultPicture")
        }
    }
}
