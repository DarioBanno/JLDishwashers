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

    func test_product_is_created_from_JSON_ProductList_fetch_by_productId() {
        
        // GIVEN I have a JSON Object for product
        let productJson = JSONStubber.load(file: "ProductList_fetch_productId")!
        
        // WHEN I create a Product from json
        let product = Product(json: productJson)
        
        // THEN the product should not be nil
        XCTAssertNotNil(product)
        
        // AND should contain values from the JSON object
        XCTAssertEqual(product?.productId, "200876")
        XCTAssertEqual(product?.title, "Leoncino Fully Integrated Dishwasher")
        XCTAssertEqual(product?.price?.now, "1,000,000.00")
        XCTAssertEqual(product?.price?.currency, "GBP")
        XCTAssertEqual(product?.media?.images?.urls?.count, 6)
        XCTAssertEqual(product?.media?.images?.urls[0], "//johnlewis.scene7.com/image1")
        XCTAssertEqual(product?.media?.images?.urls[1], "//johnlewis.scene7.com/image2")
        XCTAssertEqual(product?.media?.images?.urls[2], "//johnlewis.scene7.com/image3")
        XCTAssertEqual(product?.media?.images?.urls[3], "//johnlewis.scene7.com/image4")
        XCTAssertEqual(product?.media?.images?.urls[4], "//johnlewis.scene7.com/image5")
        XCTAssertEqual(product?.media?.images?.urls[5], "//johnlewis.scene7.com/image6")
        XCTAssertEqual(product?.details?.productInformation, "Leoncino is a white lion.")
        XCTAssertEqual(product?.displaySpecialOffer, "Lea Special Offer")
        XCTAssertEqual(product?.additionalServices?.includedServices.count, 2)
        XCTAssertEqual(product?.additionalServices?.includedServices[0], "Pasta with Pesto")
        XCTAssertEqual(product?.additionalServices?.includedServices[1], "Patacones")
        XCTAssertEqual(product?.code, "88701205")
        XCTAssertEqual(features?.count, 0)
        XCTAssertEqual(features?[0].attributes?.count, 3)
        XCTAssertEqual(features?[0].attributes?[0].name, "Dimensions")
        XCTAssertEqual(features?[0].attributes?[0].value, "H30 x W30 x D30cm")
        XCTAssertEqual(features?[0].attributes?[1].name, "Quick wash")
        XCTAssertEqual(features?[0].attributes?[1].value, "Yes")
        XCTAssertEqual(features?[0].attributes?[2].name, "Drying performance")
        XCTAssertEqual(features?[0].attributes?[2].value, "A")
    }
    
}
