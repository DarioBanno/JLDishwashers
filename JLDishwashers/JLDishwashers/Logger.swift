//
//  Logger.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

struct Logger {
    
    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
            Swift.print("DEBUG \(Date()) >: \(items[0])", separator:separator, terminator: terminator)
        #endif
    }

}
