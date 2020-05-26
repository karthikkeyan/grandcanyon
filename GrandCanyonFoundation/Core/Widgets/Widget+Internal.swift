//
//  Widget+Internal.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import Foundation

public enum WidgetKind: String {
    case unknown
    case pure
    case view
}

public protocol WidgetTypeProvider {
    var kind: WidgetKind { get }
}

public extension WidgetTypeProvider where Self: PureWidget {
    var kind: WidgetKind { return .pure }
}

public extension WidgetTypeProvider where Self: ViewWidget {
    var kind: WidgetKind { return .view }
}
