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
    @IBOutlet weak var productInformationLabel: UILabel!
    
    @IBOutlet weak var productCodeLabel: UILabel!
    
    @IBOutlet weak var productSpecificationTitleLabel: UILabel!
    
    var product: Product!
    var imageSliderViewController: ImageSliderViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Layout
        edgesForExtendedLayout = []
        
        imageSliderViewController = ImageSliderViewController()
        imageSliderViewController.view.embed(in: imageSliderContainer)
        
        priceLabel.text = ""
        priceLabel.font = Resource.Font.bigBold

        specialOfferLabel.text = ""
        specialOfferLabel.textColor = Resource.Color.importantContent

        additionalServicesLabel.text = ""
        additionalServicesLabel.textColor = Resource.Color.highlighted

        productInformationTitleLabel.text = "Product information"
        productInformationTitleLabel.font = Resource.Font.mediumBold
        
        productInformationLabel.text = ""
        productInformationLabel.lineBreakMode = .byWordWrapping
        
        productCodeLabel.text = ""
        productCodeLabel.font = Resource.Font.mediumRegular
        
        productSpecificationTitleLabel.text = "Product specification"
        productSpecificationTitleLabel.font = Resource.Font.mediumRegular
        
        // Configure with initial data from product
        configure(with: product)
        
        // Load more details for product
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
        priceLabel.text = "£\(product.price?.now ?? "--")"
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
        
        // Product information
        if let productInformation = product.details?.productInformation,
            let htmlAttributedString = NSAttributedString(html: productInformation, usingFont: Resource.Font.mediumRegular) {
            productInformationLabel.attributedText = htmlAttributedString
        }
        
        // Product code
        if let productCode = product.code {
            productCodeLabel.text = "Product code: \(productCode)"
        }
    }
    
}
