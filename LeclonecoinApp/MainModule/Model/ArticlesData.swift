//
//  ArticlesData.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

// MARK: - ArticlesData

/// A struct that represents the data for articles.
struct ArticlesData: Decodable {
    /// id: unique identifier for the article.
    let id: Int
    /// categoryId: identifier for the category of the article.
    let categoryId: Int
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

enum CodingKeys: String, CodingKey {
    case id
    case categoryId = "category_id"
    case title
    case description
    case imagesUrl = "images_url"
    case price
    case creationDate = "creation_date"
    case isUrgent = "is_urgent"
    case siret
    }
}

// MARK: - ImagesURL
                                        
/// A struct that represents the data for images.
struct ImagesURL: Decodable, Equatable {
    /// small: URL for a small-sized image.
    let small: String?
    /// thumb: URL for a thumbnail-sized image.
    let thumb: String?
}
