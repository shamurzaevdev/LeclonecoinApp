//
//  Builder.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation
import UIKit

/// A class that implements the `BuilderProtocol` for creating view controllers
final class Builder: BuilderProtocol {
    func makeArticlesViewController(router: RouterProtocol) -> UIViewController {
        let view = ArticlesViewController()
        let fetchService = FetchService()
        let viewModel = ArticlesViewModel(fetchService: fetchService, router: router)
        view.viewModel = viewModel
        return view
    }
    
    func makeDetailsViewController(router: RouterProtocol, category: CategoryData, article: ArticlesData) -> UIViewController {
        let viewModel = DetailsViewModel(articleData: article, categoryData: category)
        let view = DetailsViewController(viewModel: viewModel)
        view.viewModel = viewModel
        return view
    }
    
    func makeCategoryViewController(router: RouterProtocol, category: CategoryData, articles: [ArticlesData]) -> UIViewController {
        let viewModel = SelectedCategoryViewModel(articles: articles, category: category, router: router)
        let viewController = SelectedCategoryViewController()
        viewController.configure(with: viewModel)
        return viewController
    }
}
