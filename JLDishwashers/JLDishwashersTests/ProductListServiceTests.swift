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

}
