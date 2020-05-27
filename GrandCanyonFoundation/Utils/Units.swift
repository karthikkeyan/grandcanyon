//
//  Units.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

extension CGFloat {
    public static let quaterUnit: CGFloat = 2
    public static let halfUnit: CGFloat = 4
    public static let singleUnit: CGFloat = 8
    public static let doubleUnit: CGFloat = 16
    public static let tripleUnit: CGFloat = 24
    public static let quadrupleUnit: CGFloat = 32
}

extension UIEdgeInsets {
    public static let singleUnit = UIEdgeInsets(unit: .singleUnit)
    public static let doubleUnit = UIEdgeInsets(unit: .doubleUnit)
    public static let tripleUnit = UIEdgeInsets(unit: .tripleUnit)
    public static let quadrupleUnit = UIEdgeInsets(unit: .quadrupleUnit)

    public init(unit: CGFloat) {
        self = UIEdgeInsets(top: unit,
                            left: unit,
                            bottom: unit,
                            right: unit)
    }
    
    public init(top: CGFloat, unit: CGFloat) {
        self = UIEdgeInsets(top: top,
                            left: unit,
                            bottom: unit,
                            right: unit)
    }
    
    public init(bottom: CGFloat, unit: CGFloat) {
        self = UIEdgeInsets(top: unit,
                            left: unit,
                            bottom: bottom,
                            right: unit)
    }
    
    public init(left: CGFloat, unit: CGFloat) {
        self = UIEdgeInsets(top: unit,
                            left: left,
                            bottom: unit,
                            right: unit)
    }
    
    public init(right: CGFloat, unit: CGFloat) {
        self = UIEdgeInsets(top: unit,
                            left: unit,
                            bottom: unit,
                            right: right)
    }
    
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self = UIEdgeInsets(top: vertical,
                            left: horizontal,
                            bottom: vertical,
                            right: horizontal)
    }
    
    public init(top: CGFloat = .zero, bottom: CGFloat = .zero, horizontal: CGFloat = 0) {
        self = UIEdgeInsets(top: top,
                            left: horizontal,
                            bottom: bottom,
                            right: horizontal)
    }
    
    public init(left: CGFloat = .zero, right: CGFloat = .zero, vertical: CGFloat = 0) {
        self = UIEdgeInsets(top: vertical,
                            left: left,
                            bottom: vertical,
                            right: right)
    }
}

extension NSDirectionalEdgeInsets {
    public init(insets: UIEdgeInsets) {
        self = NSDirectionalEdgeInsets(top: insets.top,
                                       leading: insets.left,
                                       bottom: insets.bottom,
                                       trailing: insets.right)
    }
}
