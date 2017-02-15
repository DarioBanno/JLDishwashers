//
//  ProductDetailsViewController.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageSliderContainer: UIView!
    
    var product: Product!
    var imageSliderViewController: ImageSliderViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = product.title
        edgesForExtendedLayout = []
        
        imageSliderViewController = ImageSliderViewController()
        imageSliderViewController.embed(in: imageSliderContainer)
        
        loadProductDetails()
    }
    
    func loadProductDetails() {
        NetworkManager.shared.productListService.fetch(byId: product.productId!) { (product: Product?, error: HTTPClientError?) in
            DispatchQueue.main.async { [weak self] in
                guard let urlStrings = product?.media?.images?.urls, error == nil else {
                    return
                }
                self?.imageSliderViewController.configure(with: urlStrings.flatMap({ URL(httpsString: $0) }))
            }
        }
    }
    
}
