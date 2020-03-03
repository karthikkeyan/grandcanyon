//
//  ViewProvider.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/14/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

open class ViewProvider<W: Widget, V: UIView> {
    private weak var controller: WidgetController?
    
    open var shouldReuse: Bool = true
    
    public init(controller: WidgetController) {
        self.controller = controller
    }
    
    open var children: [Widget]? {
        guard let controller = self.controller else {
            assert(false, "Controller reference deallocated, could be thread-safe issue.")
            return nil
        }
        
        let built = controller.build()
        return controller.widgetAsHashable == built.asHashable ? nil : [built]
    }
    
    open func view(for widget: W) -> V {
        let parentView = V()
        parentView.directionalLayoutMargins = NSDirectionalEdgeInsets(insets: .zero)
        
        if let child = children?.first, let childView = controller?.viewForChildWidget(child, at: 0) {
            childView.translatesAutoresizingMaskIntoConstraints = false
            parentView.addSubview(childView)
            parentView.addConstraintsTo(childView: childView)
        }
        
        return parentView
    }
    
    open func update(view: V, using widget: W) { }
}

open class TypeSafeViewProvider<W: ViewWidget, V: UIView>: ViewProvider<W, V> {
    public weak var controller: ViewWidgetController<W>?
    
    public init(controller: ViewWidgetController<W>) {
        self.controller = controller
        
        super.init(controller: controller)
    }
    
    override open func view(for widget: W) -> V {
        assert(false, "ViewProvider: \(self) didn't override view(for:)")
        return super.view(for: widget)
    }
    
    override open func update(view: V, using widget: W) { }
}
