//
//  DetailsData.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

// MARK: - ArticlesData

/// A struct that represents the data for articles in Details.
struct DetailsData: Decodable {
    /// id: unique identifier for the article.
    let id: Int
    /// category: identifier for the category of the article.
    let category: String
    /// title: the title of the article.
    let title: String
    /// description: the description of the article.
    let description: String
    /// imagesUrl: URLs for images of the article.
    let imagesUrl: ImagesURL?
    /// price: the price as stated in the article.
    let price: Float
    /// creationDate: the creation date of the article.
    let creationDate: String
    /// siret: SIRET number, if present.
    let siret: String?
    /// isUrgent: whether the article is marked as urgent.
    let isUrgent: Bool
}
