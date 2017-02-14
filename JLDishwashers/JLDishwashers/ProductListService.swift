//
//  ProductListService.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

/// Service for fetching a list of Products
///
/// Example:
/// https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20
///

struct ProductListService: Service {
    
    let path = ServiceConfiguration.productListServicePath
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func search(query: String, pageSize: Int, completion: @escaping (_ products: [Product]?, _ error: HTTPClientError?) -> ()) {
        let query = "?q=\(query)&pageSize=\(pageSize)&key=\(ServiceConfiguration.apiKey)"
        let requestPath = path + "/search" + query
        
        httpClient.requestJSON(method: .get, path: requestPath) { (jsonObject, error) in
            completion([Product](jsonArray: jsonObject?["products"] as? [JSONObject]), error)
        }
    }
    
}
