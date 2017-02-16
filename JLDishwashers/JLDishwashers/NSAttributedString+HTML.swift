//
//  NSAttributedString+HTML.swift
//  JLDishwashers
//
//  Created by Dario Banno on 16/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

extension NSAttributedString {

    convenience init?(html: String, usingFont font: UIFont? = nil) {
        
        var htmlString = html
        if let font = font {
            let fontStyleTag = "style=\"font-family: '\(font.fontName)'; font-size: \(font.pointSize)\""
            htmlString = "<div \(fontStyleTag)>\(html)</div>"
        }
        
        guard let data = htmlString.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
            return nil
        }
        
        var options: [String: Any] = [
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
