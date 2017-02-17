//
//  Price.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

struct Price: JSONParsable {
    
    var was: String?
    var then1: String?
    var then2: String?
    var now: String?
    var uom: String?
    var currency: String?
    
    init?(json: JSONObject?) {
        was = json?["was"] as? String
        then1 = json?["then1"] as? String
        then2 = json?["then2"] as? String
        now = json?["now"] as? String
        uom = json?["uom"] as? String
        currency = json?["currency"] as? String

        // Validate model
        guard now != nil && currency != nil else {
            return nil
        }
    }
}
