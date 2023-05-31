//
//  ArticlesViewModelProtocol.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

// MARK: - ArticlesViewModelProtocol
/**
 A protocol that defines the capabilities of an ArticlesViewModel.
 
 - Articles: An array of ArticlesData that the ViewModel manages.
 - Categories: An array of CategoryData that the ViewModel manages.
 - onDataUpdate: A closure that gets called whenever the data updates.
 - Router: An instance of a RouterProtocol for handling view navigation.
 - numberOfArticles: A function that returns the number of articles.
 - fetchArticles: A function to fetch the articles.
 - fetchCategories: A function to fetch the categories.
 - item: A function that returns an article at a specific index.
 - pushToDetailViewController: A function to navigate to a detail view controller for a given index.
 - pushToSelectedCategoryViewConroller: A function to navigate to a selected category view controller with a given category.
 - category: A function that returns the category for a given category ID.
 - getFilteredAndSortedArticles: A function that returns a list of articles filtered and sorted by category.
 */
protocol ArticlesViewModelProtocol {
    var articles: [ArticlesData] { get }
    var categories: [CategoryData] { get }
    var onDataUpdate: (() -> Void)? { get set }
    var router: RouterProtocol { get }
    func numberOfArticles() -> Int
    func fetchArticles()
    func fetchCategories()
    func item(at index: Int) -> ArticlesData
    func pushToDetailViewController(indexPath: Int)
    func pushToSelectedCategoryViewConroller(category: CategoryData)
    func category(for categoryId: Int) -> CategoryData?
    func getFilteredAndSortedArticles(category: CategoryData) -> [ArticlesData]
}
