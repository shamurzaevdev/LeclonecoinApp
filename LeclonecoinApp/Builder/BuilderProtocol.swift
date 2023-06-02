//
//  BuilderProtocol.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import UIKit

/// A protocol that defines the methods for creating view controllers
protocol BuilderProtocol {
    func makeArticlesViewController(router: RouterProtocol) -> UIViewController
    func makeDetailsViewController(router: RouterProtocol, category: CategoryData,
                                   article: ArticlesData) -> UIViewController
    func makeCategoryViewController(router: RouterProtocol, category: CategoryData,
                                    articles: [ArticlesData]) -> UIViewController
}

