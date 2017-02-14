//
//  PriceTests.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class PriceTests: XCTestCase {
    
    var price: Price!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_price_is_populated_from_JSON() {
        // GIVEN I have a JSON stub
        let jsonStub = JSONStubber.load(file: "Price")
        
        // WHEN I create Price from json
        let price = Price(json: jsonStub)
        
        // THEN price should not be nil
        XCTAssertNotNil(price)
        
        // AND should contain values from the JSON object
        XCTAssertEqual(price?.was, "123")
        XCTAssertEqual(price?.then1, "456")
        XCTAssertEqual(price?.then2, "789")
        XCTAssertEqual(price?.now, "123.00")
        XCTAssertEqual(price?.currency, "BTC")
    }
    
    func test_price_is_not_created_when_JSON_has_no_currency() {
        // GIVEN I have a JSON stub with no currency
        let jsonStub = JSONStubber.load(file: "Price_no_currency")
        
        // WHEN I create Price from json
        let price = Price(json: jsonStub)
        
        // THEN the product should be nil
        XCTAssertNil(price)
    }
    
    func test_price_is_not_created_when_JSON_has_no_now() {
        // GIVEN I have a JSON stub with no now
        let jsonStub = JSONStubber.load(file: "Price_no_now")
        
        // WHEN I create Price from json
        let price = Price(json: jsonStub)
        
        // THEN price should be nil
        XCTAssertNil(price)
    }
}
