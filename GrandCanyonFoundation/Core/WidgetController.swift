//
//  WidgetController.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/14/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

// MARK: WidgetController
public protocol WidgetControllerInterface: class {
    var parent: WidgetControllerInterface? { get }
    var widgetAsHashable: String { get }
    
    func viewForMount(parent: WidgetControllerInterface?) -> UIView
    func viewForChildWidget(_ childWidget: Widget) -> UIView?
    func build() -> Widget
    func willMount()
    func didMount()
    func willUnMount()
    func didUnMount()
}

extension WidgetControllerInterface {
    public func willMount() { }
    public func didMount() { }
    public func willUnMount() { }
    public func didUnMount() { }
}

// MARK: WidgetController
public class WidgetController<W: Widget>: WidgetControllerInterface {
    public private(set) var widget: W
    public weak var parent: WidgetControllerInterface?
    public var widgetAsHashable: String { return widget.asHashable }
    
    private var child: WidgetControllerInterface?
    private lazy var viewProvider: ViewProvider<W, UIView> = ViewProvider<W, UIView>(controller: self)
    private var view: UIView?

    public init(widget: W) {
        self.widget = widget
    }
    
    public func viewForMount(parent: WidgetControllerInterface?) -> UIView {
        if let view = self.view {
            return view
        }
        
        self.parent = parent
        
        let rootView = viewProvider.view(for: widget)
        view = rootView
        return rootView
    }
    
    public func viewForChildWidget(_ childWidget: Widget) -> UIView? {
        if let childController = child, childWidget.asHashable == childController.widgetAsHashable {
            return childController.viewForMount(parent: self)
        }
        
        let childController = childWidget.controller()
        let childView = childController.viewForMount(parent: self)
        child = childController
        return childView
    }
    
    public func build() -> Widget {
        return widget.build()
    }
}

// MARK: ViewWidgetController
public class ViewWidgetController<W: ViewWidget>: WidgetControllerInterface {
    public private(set) var widget: W
    public weak var parent: WidgetControllerInterface?
    public var widgetAsHashable: String { return widget.asHashable }
    
    private var children: [AnyHashable: WidgetControllerInterface]?
    private lazy var viewProvider: ViewProvider<W, W.View> = widget.viewProvider(controller: self)

    public init(widget: W) {
        self.widget = widget
    }
    
    public func viewForChildWidget(_ childWidget: Widget) -> UIView? {
        if let childController = children?[childWidget.asHashable] {
            return childController.viewForMount(parent: self)
        }
        
        if children == nil {
            children = [:]
        }
        
        let childController = childWidget.controller()
        let childView = childController.viewForMount(parent: self)
        children?[childWidget.asHashable] = childController
        return childView
    }

    public func viewForMount(parent: WidgetControllerInterface?) -> UIView {
        self.parent = parent
        return viewProvider.view(for: widget)
    }
    
    public func build() -> Widget {
        return widget.build()
    }
}
