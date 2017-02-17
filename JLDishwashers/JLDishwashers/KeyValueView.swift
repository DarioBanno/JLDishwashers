//
//  KeyValueView.swift
//  JLDishwashers
//
//  Created by Dario Banno on 16/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class KeyValueView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        nameLabel.text = ""
        valueLabel.text = ""
    }
    
    func configure(name: String, value: String) {
        nameLabel.text = name
        valueLabel.text = value
    }
    
}
