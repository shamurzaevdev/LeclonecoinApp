//
//  Router.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import UIKit

/// A class that implements the `RouterProtocol` for managing navigation in the application.
class Router: RouterProtocol {
    
    
    // MARK: - Properties
    
    var navController: UINavigationController?
    var builder: BuilderProtocol
    
    // MARK: - Initialization
    
    init(navController: UINavigationController, builder: BuilderProtocol) {
        self.navController = navController
        self.builder = builder
    }
    
    // MARK: - Methods
    
    func initialController() {
        if let navController = navController {
            let articlesController = builder.makeArticlesViewController(router: self)
            navController.viewControllers = [articlesController]
        }
    }
    
    func pushDetailsViewController(category: CategoryData, article: ArticlesData) {
        if let navController = navController {
            let detailsViewController = builder.makeDetailsViewController(router: self, category: category, article: article)
            navController.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func showCategoryArticles(from category: CategoryData, articles: [ArticlesData]) {
        if let navController = navController {
            let selectedCategoryVC = builder.makeCategoryViewController(router: self, category: category, articles: articles)
            navController.pushViewController(selectedCategoryVC, animated: true)
        }
    }
}
