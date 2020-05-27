//
//  StyleModifier.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/26/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct StyleModifier: Modifier, Hashable {
    public var isHidden: Bool? = nil
    public var background: UIColor?
    
    init(isHidden: Bool? = nil, background: UIColor? = nil) {
        self.isHidden = isHidden
        self.background = background
    }
}

public extension Widget {
    @discardableResult
    func background(_ gradiant: GradiantBuilder) -> Widget {
        Gradiant(builder: gradiant) { self }
    }
    
    @discardableResult
    func background(_ color: UIColor) -> Widget {
        modifiedContent(using: StyleModifier(background: color))
    }
    
    @discardableResult
    func hidden(_ isHidden: Bool) -> Widget {
        modifiedContent(using: StyleModifier(isHidden: isHidden))
    }
}
