//
//  SelectedCategoryViewModelProtocol.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

// MARK: - SelectedCategoryViewModelProtocol

/// A protocol that defines the capabilities of an SelectedCategoryViewModel.
protocol SelectedCategoryViewModelProtocol {
    var category: CategoryData { get }
    func selectArticle(at index: Int)
    func numberOfArticles() -> Int
    func articleAt(_ index: Int) -> ArticlesData
}
