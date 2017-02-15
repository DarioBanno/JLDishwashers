//
//  URLImageView.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class URLImageView: UIImageView {

    var placeholderImage: UIImage?
    
    func load(from url: URL) {
        
        // Replace image with placeholder
        if placeholderImage != nil {
            image = placeholderImage
        } else {
            image = nil
        }
        
        // Load image from URL
        NetworkManager.shared.httpClient.requestData(method: .get, url: url) { [weak self] (data: Data?, error: HTTPClientError?) in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            self?.image = image
        }
    }
    
}
