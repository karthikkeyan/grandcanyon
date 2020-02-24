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
    func build() -> Widget
    func controller() -> WidgetControllerInterface
}

extension BuildableWidget where Self: Widget {
    public func controller() -> WidgetControllerInterface {
        return WidgetController(widget: self)
    }
}

// MARK: Widget
public protocol Widget: HashableWidget, BuildableWidget { }

// MARK: Widget: Helper Methods
extension Widget {
    var asWidgetRef: WidgetRef {
        return WidgetRef(wrappedValue: self)
    }
}

// MARK: WidgetRef
@propertyWrapper
public struct WidgetRef: Hashable {
    public var wrappedValue: Widget

    public init(wrappedValue: Widget) {
        self.wrappedValue = wrappedValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue.asHashable)
    }

    public static func ==(lhs: WidgetRef, rhs: WidgetRef) -> Bool {
        return lhs.wrappedValue.asHashable == rhs.wrappedValue.asHashable
    }
}

// MARK: WidgetRef
@propertyWrapper
public struct WidgetCollectionRef: Hashable {
    public var wrappedValue: [Widget]

    public init(wrappedValue: [Widget]) {
        self.wrappedValue = wrappedValue
    }

    public func hash(into hasher: inout Hasher) {
        wrappedValue.forEach { hasher.combine($0.asHashable) }
    }

    public static func ==(lhs: WidgetCollectionRef, rhs: WidgetCollectionRef) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
