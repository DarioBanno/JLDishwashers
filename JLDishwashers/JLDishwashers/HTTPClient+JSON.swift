//
//  HTTPClient+JSON.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import Foundation

/// Extension for JSON

extension HTTPClient {
    
    /// JSON Request
    ///
    /// Send a request with a JSON body (optional)
    ///
    /// Parameters:
    /// - method: the http method for the request
    /// - path: the URL path for the request
    /// - body: (optional) a JSON formatted body for the request
    /// - completion: completion block returning a JSON Object and error if any
    
    func requestJSON(method: HTTPRequestMethod, path: String, body: JSONObject? = nil, completion: @escaping (_ result: JSONObject?, _ error: HTTPClientError?) -> ()) {
        
        // Attach JSON body
        var jsonBody: Data? = nil
        if let body = body {
            guard JSONSerialization.isValidJSONObject(body),
                let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                else {
                    Logger.print("-- Error: unable to generate JSON data from body \(body).")
                    completion(nil, .invalidRequestJSON)
                    return
            }
            jsonBody = jsonData
        }
        
        // Send request
        requestData(method: method, path: path, body: jsonBody, contentType: "application/json") { (data: Data?, error: HTTPClientError?) in
            
            // Check data and propagate error if any
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            // Check if response is serializable
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONObject else {
                Logger.print("-- Error: Malformed JSON.")
                completion(nil, .invalidResponseJSON)
                return
            }
            
            completion(jsonObject, nil)
        }
    }
    
}
