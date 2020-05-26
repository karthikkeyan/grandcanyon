//
//  TupleWidget.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/23/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

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
