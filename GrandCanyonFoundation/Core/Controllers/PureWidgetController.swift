//
//  PureWidgetController.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/23/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public class PureWidgetController<W: Widget>: WidgetController {
    // WidgetController Properties
    public weak var parent: WidgetController?
    public var child: WidgetController?
    
    // Public Properties
    public private(set) var model: Widget
    public private(set) var widget: W
    public var widgetAsHashable: String { return widget.asHashable }
    
    // Private Properties
    private var view: UIView?
    private lazy var viewProvider: ViewProvider<W, UIView> = ViewProvider<W, UIView>(controller: self)

    public init(widget: W) {
        self.widget = widget
        self.model = widget
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
