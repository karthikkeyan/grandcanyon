//
//  WidgetController.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/14/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

// MARK: WidgetController
public protocol WidgetController: class {
    var parent: WidgetController? { get set }
    var child: WidgetController? { get set }
    var widgetAsHashable: String { get }
    var body: Widget { get }

    func viewForMount(parent: WidgetController?) -> UIView
    func viewForChildWidget(_ childWidget: Widget, at index: Int) -> UIView?
    func willMount()
    func didMount()
}

extension WidgetController {
    public func willMount() { }
    public func didMount() { }
}

// MARK: PureWidgetController
public class PureWidgetController<W: Widget>: WidgetController {
    // WidgetController Properties
    public weak var parent: WidgetController?
    public var child: WidgetController?
    
    // Public Properties
    public private(set) var widget: W
    public var widgetAsHashable: String { return widget.asHashable }
    
    // Private Properties
    private var view: UIView?
    private lazy var viewProvider: ViewProvider<W, UIView> = ViewProvider<W, UIView>(controller: self)

    public init(widget: W) {
        self.widget = widget
    }

    // MARK: Public Methods
    public func viewForMount(parent: WidgetController?) -> UIView {
        if let view = self.view {
            return view
        }
        
        self.parent = parent
        
        willMount()
        defer { didMount() }
        
        let rootView: UIView
        if widget.kind == .view {
            rootView = viewProvider.view(for: widget)
        } else {
            var nextWidget: Widget = widget.body
            var nextParentController: WidgetController = self
            var nextChildController = nextWidget.controller()
            repeat {
                nextChildController.parent = nextParentController
                nextParentController.child = nextChildController
                
                let previousHash = nextWidget.asHashable
                nextWidget = nextWidget.body
                if previousHash != nextWidget.asHashable {
                    nextParentController = nextChildController
                    nextWidget = nextWidget.body
                    nextChildController = nextWidget.controller()
                    
                    // Debugging purpose condition
                    if nextWidget.kind != .view {
                        assert(false, "Infinite loop")
                    }
                }
            } while nextWidget.kind != .view
            
            rootView = nextChildController.viewForMount(parent: nextParentController)
        }
        
        view = rootView
        return rootView
    }

    public func viewForChildWidget(_ childWidget: Widget, at index: Int) -> UIView? {
        if let childController = child, childWidget.asHashable == childController.widgetAsHashable {
            return childController.viewForMount(parent: self)
        }
        
        let childController = childWidget.controller()
        let childView = childController.viewForMount(parent: self)
        child = childController
        return childView
    }

    public var body: Widget {
        return widget.body
    }
}

// MARK: ViewWidgetController
public class ViewWidgetController<W: ViewWidget>: WidgetController {
    // WidgetController Properties
    public weak var parent: WidgetController?
    public var child: WidgetController?
    
    // Pubic Properties
    public private(set) var widget: W
    public var widgetAsHashable: String { return widget.asHashable }
    
    // Private Properties
    private lazy var viewProvider: ViewProvider<W, W.View> = widget.viewProvider(controller: self)
    private var children: [AnyHashable: WidgetController]?
    
    public init(widget: W) {
        self.widget = widget
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
        
        return viewProvider.view(for: widget)
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
