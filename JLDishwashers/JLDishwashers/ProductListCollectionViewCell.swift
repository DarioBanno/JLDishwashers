//
//  ProductListCollectionViewCell.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: URLImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFit
        imageView.placeholderImage = #imageLiteral(resourceName: "jlewis-placeholder")
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func configure(from product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "£" + (product.price?.now ?? "")
        if let productImage = product.image, let url = URL(httpsString: productImage) {
            imageView.load(from: url)
        }
    }
    
}
