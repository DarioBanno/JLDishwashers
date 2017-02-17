//
//  Logger.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

struct Logger {
    
    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
            Swift.print("DEBUG \(Date()) >: \(items[0])", separator:separator, terminator: terminator)
        #endif
    }

    static func printFonts() {
        #if DEBUG
        let fontFamilies = UIFont.familyNames
        for fontFamily in fontFamilies {
            let fontNames = UIFont.fontNames(forFamilyName: fontFamily)
            print("\(fontFamily): \(fontNames)")
        }
        #endif
    }

}
