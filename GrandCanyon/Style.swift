//
//  Style.swift
//  GrandCanyon
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

extension UIFont {
    static var sectionHeading: UIFont {
        return .systemFont(ofSize: 16, weight: .bold)
    }
    
    static var itemTitle: UIFont {
        return .systemFont(ofSize: 16, weight: .bold)
    }
    
    static var body: UIFont {
        return .systemFont(ofSize: 14, weight: .regular)
    }
}

extension UIColor {
    static var themeBlue: UIColor {
        return UIColor(red: 0.031, green: 0.459, blue: 0.882, alpha: 1)
    }
    
    static var heading: UIColor {
        return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    static var subtitle: UIColor {
        return UIColor(red: 0.369, green: 0.416, blue: 0.459, alpha: 1)
    }
    
    static var body: UIColor {
        return UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
    }
}
