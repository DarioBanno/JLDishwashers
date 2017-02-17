//
//  UIView+NibLoading.swift
//  JLDishwashers
//
//  Created by Dario Banno on 16/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Load View from its related Nib file in a given bundle
    static func loadFromNib(inBundle bundle: Bundle = .main) -> UIView {
        let nibName = String(describing: self).components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    /// Return the default size specified in the Nib
    static func nibSize(inBundle bundle: Bundle = .main) -> CGSize {
        return loadFromNib(inBundle: bundle).bounds.size
    }
    
}
