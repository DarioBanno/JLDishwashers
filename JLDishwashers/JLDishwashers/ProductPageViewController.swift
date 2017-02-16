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
    @IBOutlet weak var priceDetailsContainer: UIView!
    weak var priceDetailsView: PriceDetailsView!
    
    var product: Product!
    var imageSliderViewController: ImageSliderViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        imageSliderViewController = ImageSliderViewController()
        imageSliderViewController.view.embed(in: imageSliderContainer)
        
        let priceDetailsView = PriceDetailsView.loadFromNib() as! PriceDetailsView
        priceDetailsView.embed(in: priceDetailsContainer)
        self.priceDetailsView = priceDetailsView
        
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
        priceDetailsView.configure(with: product)
    }
    
}
