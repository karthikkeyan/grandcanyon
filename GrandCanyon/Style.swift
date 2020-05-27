//
//  Style.swift
//  GrandCanyon
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

extension UIFont {
    static var pageTitle: UIFont {
        .systemFont(ofSize: 24, weight: .bold)
    }
    
    static var sectionHeading: UIFont {
        .systemFont(ofSize: 20, weight: .bold)
    }
    
    static var itemTitle: UIFont {
        .systemFont(ofSize: 16, weight: .medium)
    }
    
    static var body: UIFont {
        .systemFont(ofSize: 14, weight: .regular)
    }
}

extension UIColor {
    static var themeBlue: UIColor {
        UIColor(red: 0.031, green: 0.459, blue: 0.882, alpha: 1)
    }
    
    static var themeBlueDark: UIColor {
        UIColor(red: 0, green: 0.361, blue: 0.725, alpha: 1)
    }
    
    static var heading: UIColor {
        UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    static var subtitle: UIColor {
        UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1)
    }
    
    static var body: UIColor {
        UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
}
