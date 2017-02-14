//
//  ProductListViewController.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class ProductListViewController: UICollectionViewController {

    var productCategory = "dishwasher"
    var productPageSize = 20

    let dataSource = ProductListCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView!.dataSource = dataSource
        collectionView!.registerNib(forClass: ProductListCollectionViewCell.self)
        
        loadProductList()
    }

    func loadProductList() {
        NetworkManager.shared.productListService.search(query: productCategory, pageSize: productPageSize) { (products, error) in
            DispatchQueue.main.async { [weak self] in
                guard let products = products, error == nil else {
                    // TODO: trigger error
                    return
                }
                
                self?.dataSource.products = products
                self?.collectionView?.reloadData()
            }
        }
    }
}
