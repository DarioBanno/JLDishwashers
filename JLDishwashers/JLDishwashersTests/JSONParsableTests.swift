//
//  JSONParsableTests.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import XCTest
@testable import JLDishwashers

fileprivate struct DummyJSONModel: JSONParsable {
    var id: String?
    var value: Int?
    
    init?(json: JSONObject?) {
        id = json?["id"] as? String
        value = json?["value"] as? Int
        
        guard id != nil else {
            return nil
        }
    }
}

class JSONParsableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_JSONObject_is_loaded() {
        // GIVEN I have a JSON Object
        let testJSONObject: JSONObject = [
            "id": "123456",
            "value": 123,
            ]
        
        // WHEN I create the related model object
        let modelObject = DummyJSONModel(json: testJSONObject)
        
        // THEN I should see all properties are loaded from the JSON object
        XCTAssertNotNil(modelObject)
        XCTAssertEqual(modelObject?.id, testJSONObject["id"] as? String)
        XCTAssertEqual(modelObject?.value, testJSONObject["value"] as? Int)
    }
    
    func test_incomplete_JSONObject_is_not_loaded() {
        // GIVEN I have an incomplete JSON Object
        let testJSONObject: JSONObject = [
            "value": 123,
            ]
        
        // WHEN I create the related model object
        let modelObject = DummyJSONModel(json: testJSONObject)
        
        // THEN I should see JSON object is not loaded
        XCTAssertNil(modelObject)
    }
    
    func test_empty_JSONObject_is_not_loaded() {
        // GIVEN I have an empty JSON Object
        let testJSONObject: JSONObject = [:]
        
        // WHEN I create the related model object
        let modelObject = DummyJSONModel(json: testJSONObject)
        
        // THEN I should see JSON object is not loaded
        XCTAssertNil(modelObject)
    }
    
    func test_JSONObject_with_no_value_is_loaded() {
        // GIVEN I have a JSON Object
        let testJSONObject: JSONObject = [
            "id": "123456",
            ]
        
        // WHEN I create the related model object
        let modelObject = DummyJSONModel(json: testJSONObject)
        
        // THEN I should see all properties are loaded from the JSON object
        XCTAssertNotNil(modelObject)
        XCTAssertEqual(modelObject?.id, testJSONObject["id"] as? String)
        XCTAssertNil(modelObject?.value)
    }
    
}
