//
//  RouterProtocol.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

/// A protocol that defines the methods for navigation in the application.
protocol RouterProtocol {
    func initialController()
    func pushDetailsViewController(category: CategoryData, article: ArticlesData)
    func showCategoryArticles(from category: CategoryData, articles: [ArticlesData])
}
