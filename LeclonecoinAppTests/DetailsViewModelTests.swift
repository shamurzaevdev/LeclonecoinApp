//
//  DetailsViewModelTests.swift
//  LeclonecoinAppTests
//
//  Created by Эл on 01.06.2023.
//

import XCTest
@testable import LeclonecoinApp

final class DetailsViewModelTests: XCTestCase {
    
    var viewModel: DetailsViewModel!
    var articleData: ArticlesData!
    var categoryData: CategoryData!

    override func setUp() {
        super.setUp()
        
        articleData = ArticlesData(id: 1,
                                   categoryId: 1,
                                   title: "title",
                                   description: "description",
                                   imagesUrl: ImagesURL(small: "small_url", thumb: "thumb_url"),
                                   price: 100,
                                   creationDate: "2023-06-01T00:00:00+0000",
                                   siret: "12345678901234",
                                   isUrgent: false)
                                   
        categoryData = CategoryData(id: 1, name: "cat")
        
        viewModel = DetailsViewModel(articleData: articleData, categoryData: categoryData)
    }

    override func tearDown() {
        viewModel = nil
        articleData = nil
        categoryData = nil
        super.tearDown()
    }
    
    func testDetailsData() {
        let detailsData = viewModel.detailsData
        XCTAssertEqual(detailsData.id, articleData.id)
        XCTAssertEqual(detailsData.category, categoryData.name)
        XCTAssertEqual(detailsData.title, articleData.title)
        XCTAssertEqual(detailsData.description, articleData.description)
        XCTAssertEqual(detailsData.imagesUrl, articleData.imagesUrl)
        XCTAssertEqual(detailsData.price, articleData.price)
        XCTAssertFalse(detailsData.isUrgent)
        XCTAssertEqual(detailsData.siret, articleData.siret)
        XCTAssertEqual(detailsData.creationDate, articleData.creationDate.formattedDate(dateStyle: .medium, timeStyle: .none))
    }
    
    func testLoadImageWithEmptyUrl() {
        let expect = expectation(description: "Image loaded")
        viewModel.loadImage(from: "") { image in
            XCTAssertNotNil(image)
            expect.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }
}
