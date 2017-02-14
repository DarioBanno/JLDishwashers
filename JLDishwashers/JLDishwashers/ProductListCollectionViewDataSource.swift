//
//  ProductListCollectionViewDataSource.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class ProductListCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var products: [Product] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductListCollectionViewCell = collectionView.dequeueNib(at: indexPath)!
        cell.configure(from: products[indexPath.row])
        return cell
    }
    
}
