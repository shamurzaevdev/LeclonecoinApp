//
//  DetailsViewModel.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation
import UIKit

/// A view model responsible for managing the data and show the data on the details screen
final class DetailsViewModel: DetailsViewModelProtocol {
    
    // MARK: - Private Properties
    
    private let articleData: ArticlesData
    private let categoryData: CategoryData
    
    // MARK: - Properties
    
    var detailsData: DetailsData {
        configureDetailsData()
    }
    
    // MARK: - Initialization
    
    init(articleData: ArticlesData, categoryData: CategoryData) {
        self.articleData = articleData
        self.categoryData = categoryData
    }
    
    // MARK: - Public Merhods
    
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        if url.isEmpty {
            completion(UIImage(named: "defaultPicture"))
        } else if let imageUrl = URL(string: url) {
            let currentTask = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                var image: UIImage? = nil
                if let data = data, let downloadedImage = UIImage(data: data), error == nil {
                    image = downloadedImage
                } else {
                    print("Failed to download image, using default.")
                    image = UIImage(named: "defaultPicture")
                }
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            currentTask.resume()
        } else {
            print("Invalid URL, using default image.")
            completion(UIImage(named: "defaultPicture"))
        }
    }
    
    // MARK: - Private Methods
    
    private func configureDetailsData() -> DetailsData {
        let creationDate = articleData.creationDate.formattedDate(dateStyle: .medium, timeStyle: .none)
        return DetailsData(id: articleData.id,
                           category: categoryData.name,
                           title: articleData.title,
                           description: articleData.description,
                           imagesUrl: articleData.imagesUrl,
                           price: articleData.price,
                           creationDate: creationDate,
                           isUrgent: articleData.isUrgent,
                           siret: articleData.siret)
    }
}
