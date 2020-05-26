//
//  Widget.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/13/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

// MARK: HashableWidget
public protocol HashableWidget {
    var asHashable: String { get }
}

extension HashableWidget where Self: Hashable {
    public var asHashable: String {
        return String(describing: AnyHashable(self))
    }
}

extension HashableWidget where Self: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.asHashable == rhs.asHashable
    }
}

public protocol BuildableWidget {
    var body: Widget { get }

    func controller() -> WidgetController
}

extension BuildableWidget where Self: Widget {
    public func controller() -> WidgetController {
        return PureWidgetController(widget: self)
    }
}

// MARK: Widget
public protocol Widget: HashableWidget, BuildableWidget, WidgetTypeProvider { }
