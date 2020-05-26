//
//  ViewWidgetController.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/23/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public class ViewWidgetController<W: ViewWidget>: WidgetController {
    // WidgetController Properties
    public weak var parent: WidgetController?
    public var child: WidgetController?
    
    // Pubic Properties
    public private(set) var model: Widget
    public private(set) var widget: W
    public var widgetAsHashable: String { return widget.asHashable }
    
    // Private Properties
    private var view: W.View?
    private lazy var viewProvider: ViewProvider<W, W.View> = widget.viewProvider(controller: self)
    private var children: [AnyHashable: WidgetController]?
    
    public init(widget: W) {
        self.widget = widget
        self.model = widget
    }

    // MARK: Public Methods
    public func viewForChildWidget(_ childWidget: Widget, at index: Int) -> UIView? {
        let childrenKey = key(for: childWidget, at: index)
        if let childController = children?[childrenKey] {
            return childController.viewForMount(parent: self)
        }

        if children == nil {
            children = [:]
        }

        let childController = childWidget.controller()
        let childView = childController.viewForMount(parent: self)
        children?[childrenKey] = childController
        return childView
    }

    public func viewForMount(parent: WidgetController?) -> UIView {
        self.parent = parent
        
        willMount()
        defer { didMount() }
        
        let view = viewProvider.view(for: widget)
        self.view = view
        return view
    }

    public var body: Widget {
        return widget.body
    }
    
    // MARK: Private Methods
    private func key(for widget: Widget, at index: Int) -> String {
        let keyString = (widget.asHashable + "\(index)")
        guard let keyData = keyString.data(using: .utf8) else {
            assert(false, "Fail to create key for Widget: \(widget) at: \(index)")
            return keyString
        }
        return keyData.base64EncodedString()
    }
}
