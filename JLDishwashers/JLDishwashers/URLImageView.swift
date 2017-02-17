//
//  URLImageView.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class URLImageView: UIImageView {

    var loadingPlaceholder: UIImage?
    var errorPlaceholder: UIImage?
    
    func load(from url: URL) {
        
        // Replace image with loading placeholder
        image = loadingPlaceholder
        
        // Load image from URL
        NetworkManager.shared.httpClient.requestData(method: .get, url: url) { [weak self] (data: Data?, error: HTTPClientError?) in
            guard let data = data, let image = UIImage(data: data) else {
                self?.image = self?.errorPlaceholder
                return
            }
            self?.fade(toImage: image)
        }
    }
    
    private func fade(toImage image: UIImage) {
        self.image = image
        alpha = 0
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.alpha = 1
        }
    }
    
}
