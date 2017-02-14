//
//  NetworkManager.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager(httpClient: HTTPClient(urlSession: URLSession.shared))
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    // List of services
    var productListService: ProductListService { return ProductListService(httpClient: httpClient) }
}
