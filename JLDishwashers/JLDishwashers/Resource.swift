//
//  Resource.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

struct Resource {

    struct Color {
        static let warrantyInfo = UIColor(colorLiteralRed: 20/255, green: 81/255, blue: 53/255, alpha: 1)
        static let specialOffer = UIColor(colorLiteralRed: 169/255, green: 0, blue: 0, alpha: 1)
        static let divider = UIColor(colorLiteralRed: 223/255, green: 222/255, blue: 210/255, alpha: 1)
        static let contentText = UIColor(white: 114/255, alpha: 1)
        static let darkText = UIColor(white: 57/255, alpha: 1)
    }
    
    struct Font {
        static let contentText =  UIFont(name: "GillSans", size: 18)
        static let contentTextLight =  UIFont(name: "GillSans-Light", size: 18)
        static let heading1 = UIFont(name: "GillSans", size: 35)
        static let heading2 = UIFont(name: "GillSans-Light", size: 28)
        static let navigationTitle = UIFont(name: "GillSans-Light", size: 22)
    }
    
}
