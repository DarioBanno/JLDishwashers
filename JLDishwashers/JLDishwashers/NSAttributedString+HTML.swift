//
//  NSAttributedString+HTML.swift
//  JLDishwashers
//
//  Created by Dario Banno on 16/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

extension NSAttributedString {

    convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
            return nil
        }
        do {
            try self.init(data: data, options: [
                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue)
                ], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
}
