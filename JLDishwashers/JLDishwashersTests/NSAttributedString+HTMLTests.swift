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
    
    func test_attributed_string_is_initialized_from_html_with_font() {
        // GIVEN I have an HTML String
        let htmlString = "<br><br>LOREM IPSUM<br>QUE DOLOR!<br>"
        
        // AND a given font
        let font = UIFont(name: "Helvetica Neue", size: 13)!
        
        // WHEN I create an attributed string
        let attributedString = NSAttributedString(html: htmlString, usingFont: font)
        
        // THEN attributedString should not be nil
        XCTAssertNotNil(attributedString)
        
        // AND attributedString should equal the original html string
        XCTAssertEqual(attributedString?.string, "\n\nLOREM IPSUM\nQUE DOLOR!\n")
        
        // AND font attribute should match the one provided
        var attributedStringFont: UIFont!
        let attributedStringRange: NSRange = NSMakeRange(attributedString!.string.characters.distance(from: attributedString!.string.startIndex, to: attributedString!.string.startIndex), attributedString!.string.characters.distance(from: attributedString!.string.startIndex, to: attributedString!.string.endIndex))
        attributedString!.enumerateAttribute(NSFontAttributeName, in: attributedStringRange, options: NSAttributedString.EnumerationOptions(rawValue: 0)) { (value, range, stop) in
            attributedStringFont = value as? UIFont
        }
        XCTAssertEqual(attributedStringFont, font)
    }
    
}
