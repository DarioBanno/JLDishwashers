//
//  Product.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

struct Product: JSONParsable {

    var productId: String?
    var title: String?
    var image: String?
    var outOfStock: Bool?
    var price: Price?
    
    init?(json: JSONObject?) {
        productId = json?["productId"] as? String
        title = json?["title"] as? String
        image = json?["image"] as? String
        outOfStock = json?["outOfStock"] as? Bool
        price = Price(json: json?["price"] as? JSONObject)
        
        // Validate model
        guard productId != nil else {
            return nil
        }
    }
}
