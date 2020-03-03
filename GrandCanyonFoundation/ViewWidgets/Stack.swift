//
//  Stack.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct Stack: ViewWidget {
    let direction: NSLayoutConstraint.Axis
    let distribution: UIStackView.Distribution
    let alignment: UIStackView.Alignment
    let spacing: CGFloat
    @WidgetCollectionRef var children: [Widget]
    
    public init(direction: NSLayoutConstraint.Axis = .vertical,
                distribution: UIStackView.Distribution = .fill,
                alignment: UIStackView.Alignment = .fill,
                spacing: CGFloat = 0,
                children: [Widget]) {
        self.direction = direction
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.children = children
    }
    
    public func viewProvider(controller: ViewWidgetController<Stack>) -> TypeSafeViewProvider<Stack, UIStackView> {
        return StackViewProvider(controller: controller)
    }
}

class StackViewProvider: TypeSafeViewProvider<Stack, UIStackView> {
    override var children: [Widget]? {
        return self.controller?.widget.children
    }
    
    override func view(for widget: Stack) -> UIStackView {
        let stack = UIStackView(frame: .zero)
        stack.axis = controller?.widget.direction ?? .vertical
        stack.distribution = controller?.widget.distribution ?? .fill
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

    override func update(view: UIStackView, using widget: Stack) { }
}

public func VerticalStack(distribution: UIStackView.Distribution = .fill,
                          alignment: UIStackView.Alignment = .fill,
                          spacing: CGFloat = 0,
                          children: [Widget]) -> Stack {
    return Stack(direction: .vertical,
                 distribution: distribution,
                 alignment: alignment,
                 spacing: spacing,
                 children: children)
}

public func HorizontalStack(distribution: UIStackView.Distribution = .fill,
                            alignment: UIStackView.Alignment = .fill,
                            spacing: CGFloat = 0,
                            children: [Widget]) -> Stack {
    return Stack(direction: .horizontal,
                 distribution: distribution,
                 alignment: alignment,
                 spacing: spacing,
                 children: children)
}
