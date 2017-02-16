//
//  NSAttributedString+HTMLTests.swift
//  JLDishwashers
//
//  Created by Dario Banno on 16/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class NSAttributedString_HTMLTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_attributed_string_is_initialized_from_html() {
        // GIVEN I have an HTML String
        let htmlString = "<br><br>LOREM IPSUM<br>QUE DOLOR!<br>"
        
        // WHEN I create an attributed string
        let attributedString = NSAttributedString(html: htmlString)
        
        // THEN attributedString should not be nil
        XCTAssertNotNil(attributedString)
        
        // AND attributedString should equal the original html string
        XCTAssertEqual(attributedString?.string, "\n\nLOREM IPSUM\nQUE DOLOR!\n")
    }
    
}
