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
    var media: Media?
    var details: Details?
    var displaySpecialOffer: String?
    var additionalServices: AdditionalServices?
    var code: String?
    
    init?(json: JSONObject?) {
        productId = json?["productId"] as? String
        title = json?["title"] as? String
        image = json?["image"] as? String
        outOfStock = json?["outOfStock"] as? Bool
        price = Price(json: json?["price"] as? JSONObject)
        media = Media(json: json?["media"] as? JSONObject)
        details = Details(json: json?["details"] as? JSONObject)
        displaySpecialOffer = json?["displaySpecialOffer"] as? String
        additionalServices = AdditionalServices(json: json?["additionalServices"] as? JSONObject)
        code = json?["code"] as? String

        // Validate model
        guard productId != nil else {
            return nil
        }
    }
    
    struct Media: JSONParsable {
        var images: Images?
        init?(json: JSONObject?) {
            images = Images(json: json?["images"] as? JSONObject)
        }
    }
    
    struct Images: JSONParsable {
        var urls: [String]?
        init?(json: JSONObject?) {
            urls = json?["urls"] as? [String]
        }
    }
    
    struct Details: JSONParsable {
        var productInformation: String?
        var features: [Feature]?
        init?(json: JSONObject?) {
            productInformation = json?["productInformation"] as? String
            features = [Feature](jsonArray: json?["features"] as? [JSONObject])
        }
    }
    
    struct AdditionalServices: JSONParsable {
        var includedServices: [String]?
        init?(json: JSONObject?) {
           includedServices = json?["includedServices"] as? [String]
        }
    }
    
    struct Feature: JSONParsable {
        var attributes: [Attribute]?
        init?(json: JSONObject?) {
            attributes = [Attribute](jsonArray: json?["attributes"] as? [JSONObject])
        }
    }
    
    struct Attribute: JSONParsable {
        var name: String?
        var value: String?
        init?(json: JSONObject?) {
            name = json?["name"] as? String
            value = json?["value"] as? String
        }
    }

}
