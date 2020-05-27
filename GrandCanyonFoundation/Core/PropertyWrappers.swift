//
//  PropertyWrappers.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import Foundation

// MARK: Single Widget Wrapper
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

// MARK: Widget Collection Wrapper
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

// MARK: Optional Widget Wrapper
@propertyWrapper
public struct OptionalWidgetRef: Hashable {
    public var wrappedValue: Widget?

    public init(wrappedValue: Widget?) {
        self.wrappedValue = wrappedValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue?.asHashable)
    }

    public static func ==(lhs: OptionalWidgetRef, rhs: OptionalWidgetRef) -> Bool {
        return lhs.wrappedValue?.asHashable == rhs.wrappedValue?.asHashable
    }
}
