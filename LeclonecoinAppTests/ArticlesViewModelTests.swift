//
//  ArticlesViewModelTests.swift
//  LeclonecoinAppTests
//
//  Created by Эл on 01.06.2023.
//

import XCTest
@testable import LeclonecoinApp

final class FetchServiceMock: FetchServiceProtocol {
    func fetch<T>(type: T.Type, endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        print("FetchServiceMock fetch is called with type: \(T.self)")
        guard T.self == ArticlesData.self || T.self == [ArticlesData].self || T.self == CategoryData.self || T.self == [CategoryData].self else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unsuported type"])
            completion(.failure(error))
            return
        }
        
        if T.self == [ArticlesData].self {
            let articlesDataMock = [ArticlesData(id: 1,
                                                categoryId: 1,
                                                title: "Mock Title",
                                                description: "Mock Description",
                                                imagesUrl:
                                                    ImagesURL(small: "https://example.com/small",
                                                              thumb: "https://example.com/thumb"),
                                                price: 100,
                                                creationDate: "2023-06-02",
                                                isUrgent: false,
                                                siret: "123123123"),
                                    ArticlesData(id: 2,
                                                 categoryId: 1,
                                                 title: "Mock Urgent Title",
                                                 description: "Mock Urgent Description",
                                                 imagesUrl:
                                                    ImagesURL(small: "https://example.com/small",
                                                              thumb: "https://example.com/thumb"),
                                                 price: 200,
                                                 creationDate: "2023-06-01",
                                                 isUrgent: true,
                                                 siret: "123123123")]
            completion(.success(articlesDataMock as! T))
        } else if T.self == [CategoryData].self {
            let categoryDataMock = [CategoryData(id: 1,
                                                name: "Mock Category",
                                                imageName: "MockImageName")]
            completion(.success(categoryDataMock as! T))
        }
    }
}

final class RouterMock: RouterProtocol {
    var initialControllerCalled = false
    var pushDetailsViewControllerCalled = false
    var showCategoryArticlesCalled = false

    func initialController() {
        initialControllerCalled = true
    }

    func pushDetailsViewController(category: CategoryData, article: ArticlesData) {
        pushDetailsViewControllerCalled = true
    }

    func showCategoryArticles(from category: CategoryData, articles: [ArticlesData]) {
        showCategoryArticlesCalled = true
    }
}

final class ArticlesViewModelTests: XCTestCase {
    
    private var viewModel: ArticlesViewModel!
    private var fetchServiceMock: FetchServiceProtocol!
    private var routerMock: RouterProtocol!

    override func setUp() {
        super.setUp()
        fetchServiceMock = FetchServiceMock()
        routerMock = RouterMock()
        viewModel = ArticlesViewModel(fetchService: fetchServiceMock,
                                      router: routerMock)
        print("ArticlesViewModelTests setup is completed")
    }
    
    override func tearDown() {
        viewModel = nil
        fetchServiceMock = nil
        routerMock = nil
        super.tearDown()
    }
    
    func testFetchArticles() {
        
        viewModel.fetchArticles()
        XCTAssertEqual(viewModel.numberOfArticles(), 2)
        XCTAssertEqual(viewModel.item(at: 0)?.title, "Mock Urgent Title")
    }
    
    func testFetchCategories() {
        viewModel.fetchCategories()
        XCTAssertEqual(viewModel.categories.count, 1)
        XCTAssertEqual(viewModel.categories[0].name, "Mock Category")
    }
    
    func testSortingArticles() {
        viewModel.fetchArticles()
        XCTAssertEqual(viewModel.numberOfArticles(), 2)
        
        let urgentArticleId = viewModel.articles.first(where: { $0.isUrgent})?.id
        let latestArticleId = viewModel.articles.first(where: { !$0.isUrgent })?.id
        
        XCTAssertEqual(viewModel.item(at: 0)?.id, urgentArticleId)
        XCTAssertEqual(viewModel.item(at: 1)?.id, latestArticleId)
    }
    
    func testFilteringArticlesByCategory() {
        let filteredArticles = viewModel.getFilteredAndSortedArticles(category: CategoryData(id: 1, name: "Mock Category", imageName: "MockImageName"))
        for article in filteredArticles {
            XCTAssertEqual(article.categoryId, 1)
            }
        }
    
    func testItemAtIndex() {
        viewModel.fetchArticles()
        XCTAssertEqual(viewModel.numberOfArticles(), 2)
        XCTAssertEqual(viewModel.item(at: 0)?.title, "Mock Urgent Title")
        XCTAssertNil(viewModel.item(at: 10))
    }
}
