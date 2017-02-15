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
    
    func test_product_is_created_from_JSON_ProductList_Search() {
        
        // GIVEN I have a JSON Object for product
        let searchJson = JSONStubber.load(file: "ProductList_search")!
        let productListJson = searchJson["products"] as! [JSONObject]
        let productJson = productListJson[0]
        
        // WHEN I create a Product from json
        let product = Product(json: productJson)
        
        // THEN the product should not be nil
        XCTAssertNotNil(product)
        
        // AND should contain values from the JSON object
        XCTAssertEqual(product?.productId, "001")
        XCTAssertEqual(product?.image, "//johnlewis.scene7.com/is/image/JohnLewis/234326372?")
        XCTAssertEqual(product?.title, "Donald Trump Fully Integrated Dishwasher")
        XCTAssertEqual(product?.outOfStock, false)
        XCTAssertNotNil(product?.price)
        XCTAssertEqual(product?.price?.now, "10,000,000.00")
        XCTAssertEqual(product?.price?.currency, "USD")
    }
    
    func test_product_is_not_created_when_JSON_is_incomplete() {
        
        // GIVEN I have a JSON Object for product
        let jsonStub = JSONStubber.load(file: "Product_no_productId")!
        
        // WHEN I create a Product from json
        let product = Product(json: jsonStub)
        
        // THEN the product should not be nil
        XCTAssertNil(product)
    }

}
