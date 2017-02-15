//
//  ProductListServiceTests.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class ProductListServiceTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        
        mockURLSession = MockURLSession()
        networkManager = NetworkManager(httpClient: HTTPClient(urlSession: mockURLSession))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_product_list_service_path() {
        // GIVEN I have a product list service
        let service = networkManager.productListService
        
        // THEN its path should be product list service path
        XCTAssertEqual(service.path, ServiceConfiguration.productListServicePath)
    }

    func test_product_list_search_returns_array_of_products() {
        
        // GIVEN I mock product list response with a valid array of products
        let json = JSONStubber.load(file: "ProductList_search")!
        mockURLSession.responseData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        mockURLSession.responseError = nil
        
        // WHEN I perform a search for "dishwasher"
        let asyncExpectation = expectation(description: #function)
        var responseProducts: [Product]?
        var responseError: HTTPClientError?
        networkManager.productListService.search(query: "dishwasher", pageSize: 10) { (products: [Product]?, error: HTTPClientError?) in
            responseProducts = products
            responseError = error
            asyncExpectation.fulfill()
        }
        
        // THEN the request should be performed within 2 seconds
        waitForExpectations(timeout: 2) { (error) in XCTAssertNil(error) }
        
        // THEN I should see no error
        XCTAssertNil(responseError)
        
        // AND I should have some products
        XCTAssertNotNil(responseProducts)
        
        // AND the number of products should be 3
        XCTAssertEqual(responseProducts?.count, 3)
        
        // AND products should be correctly populated
        XCTAssertEqual(responseProducts?[0].productId, "001")
        XCTAssertEqual(responseProducts?[1].productId, "002")
        XCTAssertEqual(responseProducts?[2].productId, "003")
    }
    
    func test_product_list_fetch_by_productId_returns_a_product() {
        
        // GIVEN I mock product list response with a valid array of products
        let json = JSONStubber.load(file: "ProductList_fetch_productId")!
        mockURLSession.responseData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        mockURLSession.responseError = nil
        
        // WHEN I perform a fetch by productId
        let asyncExpectation = expectation(description: #function)
        var responseProduct: Product?
        var responseError: HTTPClientError?
        networkManager.productListService.fetch(byId: "200876") { (product: Product?, error: HTTPClientError?) in
            responseProduct = product
            responseError = error
            asyncExpectation.fulfill()
        }
        
        // THEN the request should be performed within 2 seconds
        waitForExpectations(timeout: 2) { (error) in XCTAssertNil(error) }
        
        // THEN I should see no error
        XCTAssertNil(responseError)
        
        // AND I should have some products
        XCTAssertNotNil(responseProduct)

        // AND product should be correctly populated
        XCTAssertEqual(responseProduct?.productId, "200876")
        XCTAssertEqual(responseProduct?.title, "Leoncino Fully Integrated Dishwasher")
        XCTAssertEqual(responseProduct?.price?.now, "1,000,000.00")
        XCTAssertEqual(responseProduct?.price?.currency, "GBP")
        XCTAssertEqual(responseProduct?.media?.images?.urls?.count, 6)
        XCTAssertEqual(responseProduct?.media?.images?.urls?[0], "//johnlewis.scene7.com/image1")
        XCTAssertEqual(responseProduct?.media?.images?.urls?[1], "//johnlewis.scene7.com/image2")
        XCTAssertEqual(responseProduct?.media?.images?.urls?[2], "//johnlewis.scene7.com/image3")
        XCTAssertEqual(responseProduct?.media?.images?.urls?[3], "//johnlewis.scene7.com/image4")
        XCTAssertEqual(responseProduct?.media?.images?.urls?[4], "//johnlewis.scene7.com/image5")
        XCTAssertEqual(responseProduct?.media?.images?.urls?[5], "//johnlewis.scene7.com/image6")
        XCTAssertEqual(responseProduct?.displaySpecialOffer, "Lea Special Offer")
        XCTAssertEqual(responseProduct?.additionalServices?.includedServices?.count, 2)
        XCTAssertEqual(responseProduct?.additionalServices?.includedServices?[0], "Pasta with Pesto")
        XCTAssertEqual(responseProduct?.additionalServices?.includedServices?[1], "Patacones")
        XCTAssertEqual(responseProduct?.code, "88701205")
        XCTAssertEqual(responseProduct?.details?.productInformation, "Leoncino is a white lion.")
        XCTAssertEqual(responseProduct?.details?.features?.count, 1)
        XCTAssertEqual(responseProduct?.details?.features?[0].attributes?.count, 3)
        XCTAssertEqual(responseProduct?.details?.features?[0].attributes?[0].name, "Dimensions")
        XCTAssertEqual(responseProduct?.details?.features?[0].attributes?[0].value, "H30 x W30 x D30cm")
        XCTAssertEqual(responseProduct?.details?.features?[0].attributes?[1].name, "Quick wash")
        XCTAssertEqual(responseProduct?.details?.features?[0].attributes?[1].value, "Yes")
        XCTAssertEqual(responseProduct?.details?.features?[0].attributes?[2].name, "Drying performance")
        XCTAssertEqual(responseProduct?.details?.features?[0].attributes?[2].value, "A")
    }
    
}
