//
//  Align.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/17/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public enum Alignment {
    case top
}

public struct Align: ViewWidget {
    let align: Alignment
    @WidgetRef fileprivate var child: Widget
    
    public init(align: Alignment, @WidgetBuilder body: () -> Widget) {
        self.align = align
        let content = body()
        if let tuple = content as? TupleWidget, let first = tuple.widgets.first {
            child = first
        } else {
            child = content
        }
    }
    
    public func viewProvider(controller: ViewWidgetController<Align>) -> TypeSafeViewProvider<Align, UIView> {
        return AlignViewProvider(controller: controller)
    }
}

class AlignViewProvider: TypeSafeViewProvider<Align, UIView> {
    override var children: [Widget]? {
        guard let widget = controller?.widget.child else {
            return nil
        }
        return [widget]
    }
    
    override func view(for widget: Align) -> UIView {
        let container = UIView(frame: .zero)
        container.directionalLayoutMargins = .zero
        if let child = self.children?.first, let subview = controller?.viewForChildWidget(child, at: 0) {
            subview.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(subview)
            switch widget.align {
            case .top:
                subview.clipMargins(to: container, sides: [
                    .leading,
                    .trailing,
                    .top
                ])
            }
        }
        
        return container
    }
    
    override func update(view: UIView, using widget: Align) { }
}
