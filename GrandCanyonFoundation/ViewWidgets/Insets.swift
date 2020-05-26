//
//  Insets.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 3/2/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct Insets: ViewWidget {
    fileprivate let insets: UIEdgeInsets
    @WidgetRef fileprivate var child: Widget
    
    public init(insets: UIEdgeInsets, @WidgetBuilder body: () -> Widget) {
        let content = body()
        if let tuple = content as? TupleWidget, let first = tuple.widgets.first {
            child = first
        } else {
            child = content
        }

        self.insets = insets
    }

    public func viewProvider(controller: ViewWidgetController<Insets>) -> TypeSafeViewProvider<Insets, UIView> {
        return InsetsViewProvider(controller: controller)
    }
}

class InsetsViewProvider: TypeSafeViewProvider<Insets, UIView> {
    private weak var containerView: UIView?
    private weak var childView: UIView?
    private var constraints: [NSLayoutConstraint]?
    
    override var children: [Widget]? {
        guard let child = self.controller?.widget.child else {
            return nil
        }
        return [child]
    }
    
    override func view(for widget: Insets) -> UIView {
        print("Insets create called")
        let container = UIView(frame: .zero)
        container.directionalLayoutMargins = NSDirectionalEdgeInsets(insets: widget.insets)
        
        if let child = self.children?.first, let subview = controller?.viewForChildWidget(child, at: 0) {
            subview.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(subview)
            self.childView = subview
            self.constraints = container.addConstraintsTo(childView: subview)
        }
        
        self.containerView = container
        return container
    }

    override func update(view: UIView, using widget: Insets) {
        print("Insets updated called")
        guard let childView = self.childView,
            let constraints = self.constraints,
            let insets = controller?.widget.insets else {
            return
        }
        
        self.containerView?.directionalLayoutMargins = NSDirectionalEdgeInsets(insets: insets)
        childView.addConstraints(constraints)
        self.constraints = containerView?.addConstraintsTo(childView: childView)
    }
}
