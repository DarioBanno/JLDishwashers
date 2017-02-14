//
//  JSONParsable.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

typealias JSONObject = [String: Any]

protocol JSONParsable {
    init?(json: JSONObject?)
}

extension JSONParsable {
    
    func toJSONObject() -> JSONObject {
        var json = JSONObject()
        
        for case let (label?, value) in Mirror(reflecting: self).children {
            switch value {
            case let value as JSONParsable:
                json[label] = value.toJSONObject()
            case let value as NSObject:
                json[label] = value
            default:
                debugPrint("Error: \(label) is unserializable for value \(value)")
            }
        }
        
        return json
    }
    
}

extension Array where Element: JSONParsable {
    
    /**
     Initialize an array based on a json dictionary
     
     - parameter jsonArray: The json array
     */
    init?(jsonArray: [JSONObject]?) {
        self.init()
        
        guard let jsonArray = jsonArray else { return }
        
        for json in jsonArray {
            guard let element = Element(json: json) else {
                // Fail initializer if an element cannot be serialised.
                return nil
            }
            self += [element]
        }
    }
    
    func toJSONArray() -> [JSONObject] {
        return map { $0.toJSONObject() }
    }
    
}
