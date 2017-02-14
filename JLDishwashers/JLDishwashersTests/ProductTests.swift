//
//  ProductTests.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class ProductTests: XCTestCase {
    
    var product: Product!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_product_is_created_from_JSON() {
        
        // GIVEN I have a JSON Object for product
        let jsonStub = JSONStubber.load(file: "Product")
        
        // WHEN I create a Product from json
        let product = Product(json: jsonStub)
        
        // THEN the product should not be nil
        XCTAssertNotNil(product)
        
        // AND should contain values from the JSON object
        XCTAssertEqual(product?.productId, "1913470")
        XCTAssertEqual(product?.image, "//johnlewis.scene7.com/is/image/JohnLewis/234326372?")
        XCTAssertEqual(product?.title, "Bosch SMV53M40GB Fully Integrated Dishwasher")
        XCTAssertEqual(product?.outOfStock, false)
        XCTAssertNotNil(product?.price)
        XCTAssertEqual(product?.price?.now, "499.00")
        XCTAssertEqual(product?.price?.currency, "GBP")
    }
    
    func test_product_is_not_created_when_JSON_is_incomplete() {
        
        // GIVEN I have a JSON Object for product
        let jsonStub = JSONStubber.load(file: "Product_incomplete")
        
        // WHEN I create a Product from json
        let product = Product(json: jsonStub)
        
        // THEN the product should not be nil
        XCTAssertNil(product)
    }

}
