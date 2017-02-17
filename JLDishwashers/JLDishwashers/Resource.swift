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
        static let warrantyInfo = UIColor.green
        static let specialOffer = UIColor.red
        static let divider = UIColor(colorLiteralRed: 223/255, green: 222/255, blue: 210/255, alpha: 1)
        static let contentText = UIColor(colorLiteralRed: 114/255, green: 114/255, blue: 114/255, alpha: 1)
        // - navigationTitle
    }
    
    struct Font {
        static let contentText =  UIFont(name: "GillSans", size: 18)
        static let mediumBold = UIFont(name: "GillSans-Bold", size: 20)
        static let bigBold = UIFont(name: "GillSans-Bold", size: 30)
        
        // paragraph, heading1..6, preformatted
        // - contentText
        // - headingNavigation
        // - headingParagraph
        // - heading1
        // - heading2
    }
    
}
