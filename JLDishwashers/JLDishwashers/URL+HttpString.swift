//
//  URL+HttpString.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

extension URL {

    init?(httpString: String) {
        self.init(string: "http:" + httpString)
    }
    
    init?(httpsString: String) {
        self.init(string: "https:" + httpsString)
    }
    
}
