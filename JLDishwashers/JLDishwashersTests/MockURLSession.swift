//
//  MockURLSession.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

// Use MockURLSession and dependency injection to test network calls

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        // do nothing
    }
}

class MockURLSession: URLSession {
    
    var responseData: Data?
    var responseError: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(responseData, nil, responseError)
        return MockURLSessionDataTask()
    }
    
}
