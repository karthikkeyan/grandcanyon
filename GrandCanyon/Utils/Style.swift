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
        return UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1)
    }
    
    static var body: UIColor {
        return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
}
