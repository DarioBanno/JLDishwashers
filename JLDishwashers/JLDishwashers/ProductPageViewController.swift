//
//  ProductPageViewController.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class ProductPageViewController: UIViewController {
    
    @IBOutlet weak var imageSliderContainer: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var specialOfferLabel: UILabel!
    @IBOutlet weak var additionalServicesLabel: UILabel!
    
    @IBOutlet weak var productInformationTitleLabel: UILabel!
    @IBOutlet weak var productInformationTextLabel: UILabel!
    
    var product: Product!
    var imageSliderViewController: ImageSliderViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        imageSliderViewController = ImageSliderViewController()
        imageSliderViewController.view.embed(in: imageSliderContainer)
        
        
        priceLabel.font = Resource.Font.bigBold
        specialOfferLabel.textColor = Resource.Color.importantContent
        additionalServicesLabel.textColor = Resource.Color.highlighted
        
        priceLabel.text = ""
        specialOfferLabel.text = ""
        additionalServicesLabel.text = ""

        productInformationTitleLabel.text = "Product information"
        productInformationTextLabel.text = ""
        productInformationTextLabel.lineBreakMode = .byWordWrapping
        
        configure(with: product)
        loadProductDetails()
    }
    
    func loadProductDetails() {
        NetworkManager.shared.productListService.fetch(byId: product.productId!) { [weak self] (product: Product?, error: HTTPClientError?) in
            guard let product = product, error == nil else {
                // TODO: error case
                return
            }
            self?.configure(with: product)
        }
    }
    
    func configure(with product: Product) {
        self.product = product

        title = product.title

        // Populate image slider
        if let urlStrings = product.media?.images?.urls {
            imageSliderViewController.configure(with: urlStrings.flatMap({ URL(httpsString: $0) }))
        }
        
        // Populate price details
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
        
        // Populate Product information
        if let productInformation = product.details?.productInformation,
            let htmlAttributedString = NSAttributedString(html: productInformation, usingFont: Resource.Font.mediumRegular) {
            productInformationTextLabel.attributedText = htmlAttributedString
        }
    }
    
}
