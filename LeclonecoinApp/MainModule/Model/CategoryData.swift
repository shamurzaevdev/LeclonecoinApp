//
//  CategoryData.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

// MARK: - ImagesURL

/// A struct that represents the data for categories.
struct CategoryData: Decodable {
    
    /// id: unique identifier for the category.
    let id: Int
    
    /// name: name of the category.
    let name: String
    
    /// image: the images for the categories.
    var imageName: String?
}
