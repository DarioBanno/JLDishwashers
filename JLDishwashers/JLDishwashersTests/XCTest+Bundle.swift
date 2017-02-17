//
//  XCTest+Bundle.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import XCTest

extension XCTest {

    var testBundle: Bundle { return Bundle(for: type(of: self)) }
    
}
