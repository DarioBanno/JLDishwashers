//
//  PriceDetailsView.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class PriceDetailsView: UIView {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var specialOfferLabel: UILabel!
    @IBOutlet weak var additionalServicesLabel: UILabel!
    
    override func awakeFromNib() {
        priceLabel.text = ""
        priceLabel.font = Resource.Font.heading1
        priceLabel.textColor = Resource.Color.darkText
        
        specialOfferLabel.text = ""
        specialOfferLabel.font = Resource.Font.contentText
        specialOfferLabel.textColor = Resource.Color.specialOffer
        
        additionalServicesLabel.text = ""
        additionalServicesLabel.font = Resource.Font.contentText
        additionalServicesLabel.textColor = Resource.Color.warrantyInfo
    }
    
    func configure(with product: Product) {
        priceLabel.text = "£" + (product.price?.now ?? "--")
        specialOfferLabel.text = product.displaySpecialOffer
        
        // Add additional services separated by newline
        additionalServicesLabel.text = ""
        if let includedServices = product.additionalServices?.includedServices {
            var servicesString = ""
            for service in includedServices {
                servicesString += service + "\n"
            }
            additionalServicesLabel.text = servicesString
        }
    }
    
}
