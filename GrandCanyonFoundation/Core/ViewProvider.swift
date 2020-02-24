//
//  ViewProvider.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/14/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public class ViewProvider<W: Widget, V: UIView> {
    private weak var controller: WidgetControllerInterface?
    
    public init(controller: WidgetControllerInterface) {
        self.controller = controller
    }
    
    public var children: [Widget]? {
        guard let controller = self.controller else {
            return nil
        }
        
        let built = controller.build()
        return controller.widgetAsHashable == built.asHashable ? nil : [built]
    }
    
    public func view(for widget: W) -> V {
        let parentView = V()
        
        if let child = children?.first, let childView = controller?.viewForChildWidget(child) {
            childView.translatesAutoresizingMaskIntoConstraints = false
            parentView.addSubview(childView)
            parentView.addConstraintsTo(childView: childView)
        }
        
        return parentView
    }
    
    public func update(view: V, using widget: W) { }
}

public class TypeSafeViewProvider<W: ViewWidget, V: UIView>: ViewProvider<W, V> {
    public weak var controller: ViewWidgetController<W>?
    
    public init(controller: ViewWidgetController<W>) {
        self.controller = controller
        
        super.init(controller: controller)
    }
}
