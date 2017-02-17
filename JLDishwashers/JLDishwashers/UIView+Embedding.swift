//
//  UIView+Embeddable.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Embed view in a specified container
    func embed(in container: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        let viewString = "view"
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(viewString)]|", options: .alignAllCenterY, metrics: nil, views: [viewString:self]))
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[\(viewString)]|", options: .alignAllCenterX, metrics: nil, views: [viewString:self]))
    }
    
}
