//
//  ArticlesViewModel.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation

/// A view model responsible for managing the data and interacting with the FetchService
final class ArticlesViewModel: ArticlesViewModelProtocol {
    
    // MARK: - Private Properties
    
    private let fetchService: FetchServiceProtocol
    private var categoryFilter: CategoryData?
    
    // MARK: - Properties
    
    var articles: [ArticlesData] = []
    var categories: [CategoryData] = []
    var router: RouterProtocol
    var onDataUpdate: (() -> Void)?
    
    // MARK: - Initialization
    
    init(fetchService: FetchServiceProtocol, router: RouterProtocol) {
        self.fetchService = fetchService
        self.router = router
    }
    
    // MARK: - Methods
    
    func numberOfArticles() -> Int {
        articles.count
    }
    
    func category(for categoryId: Int) -> CategoryData? {
        return categories.first(where: { $0.id == categoryId })
    }
    
    func fetchArticles() {
        self.fetchService.fetch(type: [ArticlesData].self, endpoint: .articles) { [weak self] result in
            switch result {
            case .success(let articles):
                guard let self = self else { return }
                    
                var filteredArticles = articles
                if let categoryFilter = self.categoryFilter {
                    filteredArticles = articles.filter { $0.categoryId == categoryFilter.id }
                }
                    
                filteredArticles.sort { (articleOne, articleTwo) -> Bool in
                    if articleOne.isUrgent != articleTwo.isUrgent {
                        return articleOne.isUrgent
                    } else {
                        let formatter = ISO8601DateFormatter()
                        if let dateOne = formatter.date(from: articleOne.creationDate),
                            let dateTwo = formatter.date(from: articleTwo.creationDate) {
                            return dateOne > dateTwo
                        }
                        return false
                    }
                }
                
                self.articles = filteredArticles
                DispatchQueue.main.async {
                    self.onDataUpdate?()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCategories() {
        self.fetchService.fetch(type: [CategoryData].self, endpoint: .categories) { [weak self] result in
            switch result {
            case .success(let categories):
                guard let self = self else { return }
                    
                var categoriesWithImages: [CategoryData] = []
                    
                for category in categories {
                    var categoryWithImage = category
                    switch category.name {
                    case "Véhicule":
                        categoryWithImage.imageName = "vehiculesImage"
                    case "Mode":
                        categoryWithImage.imageName = "mode"
                    case "Bricolage":
                        categoryWithImage.imageName = "bricolage"
                    case "Maison":
                        categoryWithImage.imageName = "maison"
                    case "Loisirs":
                        categoryWithImage.imageName = "loisirs"
                    case "Immobilier":
                        categoryWithImage.imageName = "immobilier"
                    case "Livres/CD/DVD":
                        categoryWithImage.imageName = "livresCdDvd"
                    case "Multimédia":
                        categoryWithImage.imageName = "multimedia"
                    case "Service":
                        categoryWithImage.imageName = "service"
                    case "Animaux":
                        categoryWithImage.imageName = "animaux"
                    case "Enfants":
                        categoryWithImage.imageName = "enfants"
                    default:
                        categoryWithImage.imageName = nil
                    }
                    categoriesWithImages.append(categoryWithImage)
                }
                print("Categories fetched, count: \(categories.count)")
                self.categories = categoriesWithImages
                DispatchQueue.main.async {
                    self.onDataUpdate?()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getFilteredAndSortedArticles(category: CategoryData) -> [ArticlesData] {
        let filteredArticles = self.articles.filter { $0.categoryId == category.id }

        let sortedArticles = filteredArticles.sorted { (articleOne, articleTwo) -> Bool in
            if articleOne.isUrgent != articleTwo.isUrgent {
                return articleOne.isUrgent
            } else {
                let formatter = ISO8601DateFormatter()
                if let dateOne = formatter.date(from: articleOne.creationDate),
                   let dateTwo = formatter.date(from: articleTwo.creationDate) {
                    return dateOne > dateTwo
                }
                return false
            }
        }
        return sortedArticles
    }
    
    func item(at index: Int) -> ArticlesData? {
        guard index >= 0 && index < articles.count else {
            return nil
        }
        return articles[index]
    }
    
    func pushToDetailViewController(indexPath: Int) {
        let article = articles[indexPath]
        guard let category = category(for: article.categoryId) else { return }
        router.pushDetailsViewController(category: category, article: article)
    }
    
    func pushToSelectedCategoryViewConroller(category: CategoryData) {
        
       let articlesInCategory = getFilteredAndSortedArticles(category: category)
        router.showCategoryArticles(from: category, articles: articlesInCategory)
    }
}
