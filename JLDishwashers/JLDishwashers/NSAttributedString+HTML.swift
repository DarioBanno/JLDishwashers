//
//  NSAttributedString+HTML.swift
//  JLDishwashers
//
//  Created by Dario Banno on 16/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

extension NSAttributedString {

    /// Initialize an NSAttributedString from an HTML string.
    ///
    /// Parameters:
    /// - html: the HTML string
    /// - usingFont: (optional) the font the should be used if no font is provided in the html
    ///
    /// Please note:
    /// - if font contains any bold or italic attributes, these will override any font attribute specified in HTML
    /// - NSAttributedString will default to Times New Roman if no font is provided in both html or usingFont
    ///
    convenience init?(html: String, usingFont font: UIFont? = nil) {
       
        // By default NSAttributedString uses TimesNewRoman for HTML, therefore we need to manually apply a div containing a global font style.
        var htmlString = html
        if let font = font {
            let fontStyleTag = "style=\"font-family: '\(font.fontName)'; font-size: \(font.pointSize); color:#727272\""
            htmlString = "<div \(fontStyleTag)>\(html)</div>"
        }
        
        guard let data = htmlString.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
            return nil
        }
        
        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue),
        ]
        
        do {
            try self.init(data: data, options: options, documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
}
