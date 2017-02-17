//
//  Service.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

protocol Service {
    var path: String { get }
    
    init(httpClient: HTTPClient)
}
