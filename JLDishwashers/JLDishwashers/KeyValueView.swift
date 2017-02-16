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
        nameLabel.font = Resource.Font.mediumRegular
        valueLabel.font = Resource.Font.mediumRegular
    }
    
}
