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
        priceLabel.font = Resource.Font.bigBold
        specialOfferLabel.textColor = Resource.Color.importantContent
        additionalServicesLabel.textColor = Resource.Color.highlighted
        
        priceLabel.text = ""
        specialOfferLabel.text = ""
        additionalServicesLabel.text = ""
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
