//
//  SelectedCategoryViewModel.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

/// A view model responsible for managing the data to choose the category
final class SelectedCategoryViewModel: SelectedCategoryViewModelProtocol {
    
    // MARK: - Private prorerties
    private var articles: [ArticlesData]
    private var router: RouterProtocol
    
    // MARK: - Properties
    
    var category: CategoryData
    
    // MARK: - Initializers
    
    init(articles: [ArticlesData], category: CategoryData, router: RouterProtocol) {
        self.articles = articles
        self.category = category
        self.router = router
    }
    
    // MARK: - Methods
    
    func selectArticle(at index: Int) {
        let article = articles[index]
        router.pushDetailsViewController(category: category, article: article)
    }
    
    func numberOfArticles() -> Int {
        return articles.count
    }
    
    func articleAt(_ index: Int) -> ArticlesData {
        return articles[index]
    }
}
