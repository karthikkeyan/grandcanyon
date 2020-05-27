//
//  SizeModifier.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/26/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct SizeModifier: Modifier, Hashable {
    public var height: CGFloat?
    public var width: CGFloat?
    
    public init(height: CGFloat) {
        self.height = height
        self.width = nil
    }
    
    public init(width: CGFloat) {
        self.width = width
        self.height = nil
    }
    
    public init(size: CGSize) {
        self.width = size.width
        self.height = size.height
    }
}

public extension Widget {
    @discardableResult
    func height(_ dimension: CGFloat) -> Widget {
        modifiedContent(using: SizeModifier(height: dimension))
    }

    @discardableResult
    func width(_ dimension: CGFloat) -> Widget {
        modifiedContent(using: SizeModifier(width: dimension))
    }

    @discardableResult
    func size(_ dimensions: CGSize) -> Widget  {
        modifiedContent(using: SizeModifier(size: dimensions))
    }
}
