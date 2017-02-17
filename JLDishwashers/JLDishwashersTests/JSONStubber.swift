//
//  JSONStubber.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation
@testable import JLDishwashers

class JSONStubber {
    static func load(file: String) -> JSONObject? {
        guard let path = Bundle(for: type(of: JSONStubber())).path(forResource: file, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONObject else {
                Logger.print("Unable to load JSON from file: \(file)")
                return nil
        }
        return json
    }
}
