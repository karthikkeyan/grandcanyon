//
//  OffSetModifier.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/26/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct OffsetModifier: Modifier, Hashable {
    let x: CGFloat
    let y: CGFloat
    let z: CGFloat
}

public extension Widget {
    @discardableResult
    func offsetBy(x: CGFloat = .zero, y: CGFloat = .zero, z: CGFloat = .zero) -> Widget {
        modifiedContent(using: OffsetModifier(x: x, y: y, z: z))
    }
}
