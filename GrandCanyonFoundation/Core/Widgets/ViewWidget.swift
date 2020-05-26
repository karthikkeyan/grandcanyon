//
//  ViewWidget.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/17/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public protocol ViewWidget: Widget, Hashable {
    associatedtype View: UIView
    func viewProvider(controller: ViewWidgetController<Self>) -> TypeSafeViewProvider<Self, View>
}

extension BuildableWidget where Self: ViewWidget {
    public var body: Widget { return self }
    
    public func controller() -> WidgetController {
        return typeSafeController()
    }
    
    private func typeSafeController() -> ViewWidgetController<Self> {
        return ViewWidgetController(widget: self)
    }
}
