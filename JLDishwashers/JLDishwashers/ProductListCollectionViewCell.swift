//
//  ProductListCollectionViewCell.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFit
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func configure(from product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "£" + (product.price?.now ?? "")
        loadImage(from: product.image)
    }
    
    func loadImage(from path: String?) {
        imageView.image = #imageLiteral(resourceName: "jlewis-placeholder")
        
        guard let path = path else {
            return
        }
        
        NetworkManager.shared.httpClient.requestData(method: .get, path: "https:" + path) { (data: Data?, error: HTTPClientError?) in
            DispatchQueue.main.async { [weak self] in
                guard let data = data,
                    let image = UIImage(data: data) else {
                        return
                }
                self?.imageView.image = image
            }
        }
    }
    
}
