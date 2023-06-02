//
//  SelectedCategoryViewModelTests.swift
//  LeclonecoinAppTests
//
//  Created by Эл on 01.06.2023.
//

import XCTest
@testable import LeclonecoinApp

final class SelectedCategoryViewModelTests: XCTestCase {
    
    private var viewModel: SelectedCategoryViewModel!
    private var routerMock: RouterMock!
    
    override func setUp() {
        super.setUp()
        
        let mockCategory = CategoryData(id: 1, name: "Mock Category", imageName: "MockImageName")
        let mockArticles = [
            ArticlesData(id: 1, categoryId: 1, title: "Mock Title 1", description: "Mock Description", imagesUrl: nil, price: 10, creationDate: "2023-05-31", siret: nil, isUrgent: true),
            ArticlesData(id: 2, categoryId: 1, title: "Mock Title 2", description: "Mock Description", imagesUrl: nil, price: 20, creationDate: "2023-05-31", siret: nil, isUrgent: false)
        ]
        routerMock = RouterMock()
        viewModel = SelectedCategoryViewModel(articles: mockArticles, category: mockCategory, router: routerMock)
    }
    
    override func tearDown() {
        viewModel = nil
        routerMock = nil
        super.tearDown()
    }
    
    func testNumberOfArticles() {
        XCTAssertEqual(viewModel.numberOfArticles(), 2)
    }
    
    func testArticleAt() {
        XCTAssertEqual(viewModel.articleAt(0).title, "Mock Title 1")
        XCTAssertEqual(viewModel.articleAt(1).title, "Mock Title 2")
    }
    
    func testSelectArticle() {
        viewModel.selectArticle(at: 0)
        XCTAssertTrue(routerMock.pushDetailsViewControllerCalled)
    }
}
