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
    }
    
    func loadProductDetails() {
        // TODO
    }
    
}
