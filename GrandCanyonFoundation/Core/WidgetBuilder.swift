//
//  WidgetBuilder.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/22/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

@_functionBuilder
public struct WidgetBuilder {
    public static func buildBlock(_ widgets: Widget...) -> Widget {
        return TupleWidget(widgets: widgets)
    }
    
    public static func buildBlock(_ widget: Widget) -> Widget {
        return widget
    }
    
    public static func buildEither(first: Widget) -> Widget {
        return first
    }
    
    public static func buildEither(second: Widget) -> Widget {
        return second
    }

    public static func buildOptional(_ widget: Widget?) -> Widget? {
        return widget
    }
}

// MARK: - ForEach

public struct ForEach: ViewWidget {
    internal let id = UUID()
    internal let widgets: [Widget]
    
    public init<T>(_ items: [T], _ iteration: (T) -> Widget) {
        widgets = items.map(iteration)
    }
    
    public func viewProvider(
        controller: ViewWidgetController<ForEach>
    ) -> TypeSafeViewProvider<ForEach, UIView> {
        return TupleViewProvider(controller: controller)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - TupleWidget

internal struct TupleWidget: ViewWidget {
    private let _widgets: [Widget]
    var widgets: [Widget] {
        var result: [Widget] = []
        for item in _widgets {
            if let tuple = item as? TupleWidget {
                result.append(contentsOf: tuple.widgets)
            } else if let loop = item as? ForEach {
                result.append(contentsOf: loop.widgets)
            } else {
                result.append(item)
            }
        }
        return result
    }
    
    init(widgets: [Widget]) {
        _widgets = widgets
    }

    func viewProvider(
        controller: ViewWidgetController<TupleWidget>
    ) -> TypeSafeViewProvider<TupleWidget, UIView> {
        return TupleViewProvider(controller: controller)
    }

    func hash(into hasher: inout Hasher) {
        widgets.forEach { hasher.combine($0.asHashable) }
    }
}

internal class TupleViewProvider<T: ViewWidget>: TypeSafeViewProvider<T, UIView> {
    override func view(for widget: T) -> EmptyView {
        return EmptyView()
    }
    
    override func update(view: UIView, using widget: T) { }
}

internal class EmptyView: UIView { }
