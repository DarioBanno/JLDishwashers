//
//  Resource.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

struct Resource {

    // TODO: create extensions for UIColor and UIFont
    
    struct Color {
        static let highlighted = UIColor.green
        static let importantContent = UIColor.red
        static let divider = UIColor.lightGray
    }
    
    struct Font {
        static let mediumRegular = UIFont.systemFont(ofSize: 20)
        static let mediumBold = UIFont.boldSystemFont(ofSize: 20)
        static let bigBold = UIFont.boldSystemFont(ofSize: 30)
        
        // paragraph, heading1..6, preformatted
    }
    
}
