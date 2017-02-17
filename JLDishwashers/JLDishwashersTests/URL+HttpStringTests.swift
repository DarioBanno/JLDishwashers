//
//  URL+HttpStringTests.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class URL_HttpStringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_httpString_initializer_succeeds() {
        // GIVEN I have a path without https
        let path = "//www.apptown.io"
        
        // WHEN I create a URL with httpsString
        let url = URL(httpString: path)
        
        // THEN url is not nil
        XCTAssertNotNil(url)
        
        // AND its address is same as path prefixing "http:"
        XCTAssertEqual(url?.absoluteString, "http:" + path)
    }
    
    func test_httpsString_initializer_succeeds() {
        // GIVEN I have a path without https
        let path = "//www.apptown.io"
        
        // WHEN I create a URL with httpsString
        let url = URL(httpsString: path)
        
        // THEN url is not nil
        XCTAssertNotNil(url)
        
        // AND its address is same as path prefixing "https:"
        XCTAssertEqual(url?.absoluteString, "https:" + path)
    }
    
}
