//
//  UICollectionView+Reusable.swift
//  JLDishwashers
//
//  Created by Dario Banno on 14/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerNib(forClass viewClass: AnyClass, bundle: Bundle? = nil) {
        let identifier = reuseIdentifier(forClass: viewClass.self)
        let nib = UINib(nibName: String(describing: viewClass), bundle: bundle)
        register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueNib<T: Any>(at indexPath: IndexPath) -> T? {
        let identifier = reuseIdentifier(forClass: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
    }
    
    private func reuseIdentifier(forClass viewClass: Any) -> String {
        return String(describing: viewClass)
    }
    
}
