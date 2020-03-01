//
//  VerticalStack.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct VerticalStack: ViewWidget {
    let spacing: CGFloat
    @WidgetCollectionRef var children: [Widget]
    
    public init(spacing: CGFloat = 0, children: [Widget]) {
        self.spacing = spacing
        self.children = children
    }
    
    public func viewProvider(controller: ViewWidgetController<VerticalStack>) -> TypeSafeViewProvider<VerticalStack, UIStackView> {
        return VerticalStackViewProvider(controller: controller)
    }
}

class VerticalStackViewProvider: TypeSafeViewProvider<VerticalStack, UIStackView> {
    override var children: [Widget]? {
        return self.controller?.widget.children
    }
    
    override func view(for widget: VerticalStack) -> UIStackView {
        let stack = UIStackView(frame: .zero)
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = controller?.widget.spacing ?? 0
        
        if let children = self.children {
            for (index, child) in children.enumerated() {
                guard let subview = controller?.viewForChildWidget(child, at: index) else {
                    continue
                }
                
                stack.addArrangedSubview(subview)
            }
        }
        
        return stack
    }

    override func update(view: UIStackView, using widget: VerticalStack) { }
}
