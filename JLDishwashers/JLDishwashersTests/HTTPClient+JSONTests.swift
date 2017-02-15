//
//  HTTPClient+JSONTests.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class HTTPClient_JSONTests: XCTestCase {
    
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
    
    
    func test_valid_request_with_some_JSON_and_no_error_response_succeeds() {
        
        // GIVEN I have a request with a valid URL
        let url = URL(string: "http://www.apptown.io")!
        
        // AND I mock the response to return data and no error
        let someJSON = ["name":"Json Lewis"] as [String: Any]
        mockURLSession.responseData = try! JSONSerialization.data(withJSONObject: someJSON, options: .prettyPrinted)
        mockURLSession.responseError = nil
        
        // WHEN I send a service request
        let asyncExpectation = expectation(description: #function)
        var responseJSON: [String: Any]?
        var responseError: HTTPClientError?
        
        httpClient.requestJSON(method: .get, url: url) { (jsonObject: [String : Any]?, error: HTTPClientError?) in
            responseJSON = jsonObject
            responseError = error
            asyncExpectation.fulfill()
        }
        
        // THEN I should get a response within 2 seconds
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNil(error)
        }
        
        // AND response JSON should not be nil
        XCTAssertNotNil(responseJSON)
        
        // AND response error should be nil
        XCTAssertNil(responseError)
    }
    
    func test_valid_request_with_empty_data_no_error_response_succeeds() {
        
        // GIVEN I have a request with a valid URL
        let url = URL(string: "http://www.apptown.io")!
        
        // AND I mock the response to return empty data and no error
        mockURLSession.responseData = Data()
        mockURLSession.responseError = nil
        
        // WHEN I send a service request
        let asyncExpectation = expectation(description: #function)
        var responseJSON: [String: Any]?
        var responseError: HTTPClientError?
        
        httpClient.requestJSON(method: .get, url: url) { (jsonObject: [String : Any]?, error: HTTPClientError?) in
            responseJSON = jsonObject
            responseError = error
            asyncExpectation.fulfill()
        }
        
        // THEN I should get a response within 2 seconds
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNil(error)
        }
        
        // AND response JSON should be nil
        XCTAssertNil(responseJSON)
        
        // AND response error should be Nil
        XCTAssertNil(responseError)
    }
    
    func test_request_with_malformed_JSON_returns_error() {
        
        // GIVEN I have a request with an unserializable JSON
        struct SomeStruct { var someValue: Int } // this is not compatible with JSONSerialization
        let unserializableJSON = ["asd":SomeStruct(someValue: 1)]
        
        // WHEN I send a service request
        let asyncExpectation = expectation(description: #function)
        var responseJSON: [String: Any]?
        var responseError: HTTPClientError?
        
        httpClient.requestJSON(method: .post, url: URL(string: "http://apptown.io")!, body: unserializableJSON) { (jsonObject: [String : Any]?, error: HTTPClientError?) in
            responseJSON = jsonObject
            responseError = error
            asyncExpectation.fulfill()
        }
        
        // THEN I should get a response within 2 seconds
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNil(error)
        }
        
        // AND response JSON should be nil
        XCTAssertNil(responseJSON)
        
        // AND response error should be invalid request
        guard case .invalidRequestJSON = responseError! else {
            XCTFail(#function)
            return
        }
    }
    
    func test_response_with_error_returns_error() {
        
        // GIVEN I have a response with an error
        enum TestError: Error { case test }
        mockURLSession.responseError = TestError.test
        
        // WHEN I send a service request
        let asyncExpectation = expectation(description: #function)
        var responseJSON: [String: Any]?
        var responseError: HTTPClientError?
        
        httpClient.requestJSON(method: .post, url: URL(string: "http://apptown.io")!) { (jsonObject: [String : Any]?, error: HTTPClientError?) in
            responseJSON = jsonObject
            responseError = error
            asyncExpectation.fulfill()
        }
        
        // THEN I should get a response within 2 seconds
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNil(error)
        }
        
        // AND response JSON should be nil
        XCTAssertNil(responseJSON)
        
        // AND response error should be invalid response
        guard case .unexpectedResponse(_) = responseError! else {
            XCTFail(#function)
            return
        }
    }
    
    func test_response_with_no_data_returns_error() {
        
        // GIVEN I mock a response with no data
        mockURLSession.responseData = nil
        
        // WHEN I send a service request
        let asyncExpectation = expectation(description: #function)
        var responseJSON: [String: Any]?
        var responseError: HTTPClientError?
        
        httpClient.requestJSON(method: .post, url: URL(string: "http://apptown.io")!) { (jsonObject: [String : Any]?, error: HTTPClientError?) in
            responseJSON = jsonObject
            responseError = error
            asyncExpectation.fulfill()
        }
        
        // THEN I should get a response within 2 seconds
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNil(error)
        }
        
        // AND response JSON should be nil
        XCTAssertNil(responseJSON)
        
        // AND response error should be No Data
        guard case .unexpectedResponseNoData = responseError! else {
            XCTFail(#function)
            return
        }
    }
    
}
