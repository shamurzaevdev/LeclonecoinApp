//
//  ArticlesViewModelProtocol.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

// MARK: - ArticlesViewModelProtocol

/// A protocol that defines the capabilities of an ArticlesViewModel.
protocol ArticlesViewModelProtocol {
    var articles: [ArticlesData] { get }
    var categories: [CategoryData] { get }
    var onDataUpdate: (() -> Void)? { get set }
    var router: RouterProtocol { get }
    func numberOfArticles() -> Int
    func fetchArticles()
    func fetchCategories()
    func item(at index: Int) -> ArticlesData?
    func pushToDetailViewController(indexPath: Int)
    func pushToSelectedCategoryViewConroller(category: CategoryData)
    func category(for categoryId: Int) -> CategoryData?
    func getFilteredAndSortedArticles(category: CategoryData) -> [ArticlesData]
}
