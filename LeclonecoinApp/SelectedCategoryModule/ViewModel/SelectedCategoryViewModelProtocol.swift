//
//  SelectedCategoryViewModelProtocol.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

// MARK: - SelectedCategoryViewModelProtocol
/**
 A protocol that defines the capabilities of an SelectedCategoryViewModel.
 
 - category: The category data of the selected category..
 - numberOfArticles:  A function that returns the number of articles in the selected category.
 - articleAt: A function that returns an article at a specific index.
 */
protocol SelectedCategoryViewModelProtocol {
    var category: CategoryData { get }
    
    func numberOfArticles() -> Int
    func articleAt(_ index: Int) -> ArticlesData
}
