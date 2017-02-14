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
    
}
