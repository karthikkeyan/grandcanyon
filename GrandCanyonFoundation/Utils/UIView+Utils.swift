//
//  UIView+Utils.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    public func addConstraintsTo(childView: UIView) -> [NSLayoutConstraint] {
        let constraints = [
            childView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            childView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            childView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
