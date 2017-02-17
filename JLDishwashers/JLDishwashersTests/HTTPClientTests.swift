//
//  HTTPClientTests.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class HTTPClientTests: XCTestCase {
    
    var httpClient: HTTPClient!
    var mockURLSession: MockURLSession!
    
    
    override func setUp() {
        super.setUp()
        
        mockURLSession = MockURLSession()
        httpClient = HTTPClient(urlSession: mockURLSession)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func test_valid_request_with_some_data_and_no_error_response_succeeds() {
        
        // GIVEN I have a request with a valid URL
        let url = URL(string: "http://www.apptown.io")!
        
        // AND I'm expecting a string as a response
        let stringResponse = "Try our new hamburger: The McDonald Trump!"
        
        // AND I mock the response to return data and no error
        let someData = stringResponse.data(using: String.Encoding.utf8)
        mockURLSession.responseData = someData
        mockURLSession.responseError = nil
        
        // WHEN I send a service request
        let asyncExpectation = expectation(description: #function)
        var responseData: Data?
        var responseError: HTTPClientError?
        var isMainThread: Bool?
        
        httpClient.requestData(method: .get, url: url) { (data: Data?, error: HTTPClientError?) in
            responseData = data
            responseError = error
            isMainThread = Thread.isMainThread
            asyncExpectation.fulfill()
        }
        
        // THEN I should get a response within 2 seconds
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNil(error)
        }
        
        // AND response data should not be nil
        XCTAssertNotNil(responseData)
        
        // AND response data should match the original string
        XCTAssertEqual(String(data: responseData!, encoding: String.Encoding.utf8), stringResponse)
        
        // AND response error should be nil
        XCTAssertNil(responseError)
        
        // AND completion should be executed on main thread
        XCTAssertTrue(isMainThread!)
    }
    
    func test_valid_request_with_empty_data_no_error_response_succeeds() {
        
        // GIVEN I have a request with a valid URL
        let url = URL(string: "http://www.apptown.io")!
        
        // AND I mock the response to return empty data and no error
        mockURLSession.responseData = Data()
        mockURLSession.responseError = nil
        
        // WHEN I send a service request
        let asyncExpectation = expectation(description: #function)
        var responseData: Data?
        var responseError: HTTPClientError?
        var isMainThread: Bool?

        httpClient.requestData(method: .get, url: url) { (data: Data?, error: HTTPClientError?) in
            responseData = data
            responseError = error
            isMainThread = Thread.isMainThread
            asyncExpectation.fulfill()
        }
        
        // THEN I should get a response within 2 seconds
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNil(error)
        }
        
        // AND response data should be nil
        XCTAssertNil(responseData)
        
        // AND response error should be nil
        XCTAssertNil(responseError)

        // AND completion should be executed on main thread
        XCTAssertTrue(isMainThread!)
    }
    
    func test_response_with_error_returns_error() {
        
        // GIVEN I have a response with an error
        enum TestError: Error { case test }
        mockURLSession.responseError = TestError.test
        
        // WHEN I send a service request
        let asyncExpectation = expectation(description: #function)
        var responseData: Data?
        var responseError: HTTPClientError?
        var isMainThread: Bool?

        httpClient.requestData(method: .post, url: URL(string: "http://apptown.io")!) { (data: Data?, error: HTTPClientError?) in
            responseData = data
            responseError = error
            isMainThread = Thread.isMainThread
            asyncExpectation.fulfill()
        }
        
        // THEN I should get a response within 2 seconds
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNil(error)
        }
        
        // AND response data should be nil
        XCTAssertNil(responseData)
        
        // AND response error should be invalid response
        guard case .unexpectedResponse(_) = responseError! else {
            XCTFail(#function)
            return
        }

        // AND completion should be executed on main thread
        XCTAssertTrue(isMainThread!)
    }
    
    func test_response_with_no_data_returns_error() {
        
        // GIVEN I have a response with no data
        mockURLSession.responseData = nil
        
        // WHEN I send a service request
        let asyncExpectation = expectation(description: #function)
        var responseData: Data?
        var responseError: HTTPClientError?
        var isMainThread: Bool?

        httpClient.requestData(method: .post, url: URL(string: "http://apptown.io")!) { (data: Data?, error: HTTPClientError?) in
            responseData = data
            responseError = error
            isMainThread = Thread.isMainThread
            asyncExpectation.fulfill()
        }
        
        // THEN I should get a response within 2 seconds
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNil(error)
        }
        
        // AND response data should be nil
        XCTAssertNil(responseData)
        
        // AND response error should be no Data
        guard case .unexpectedResponseNoData = responseError! else {
            XCTFail(#function)
            return
        }

        // AND completion should be executed on main thread
        XCTAssertTrue(isMainThread!)
    }
    
}
