//
//  ShadowContainer.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct ShadowConatinerBuilder: Hashable {
    public var shadowColor: UIColor = .lightGray
    public var opacity: Float = 0.2
    public var offset: CGSize = CGSize(width: 0, height: .halfUnit)
    public var radius: CGFloat = .singleUnit
    public var blur: CGFloat = .quaterUnit
    public var backgroundColor: UIColor = .white
}

public struct ShadowContainer: ViewWidget {
    @WidgetRef public var child: Widget
    
    fileprivate let builder: ShadowConatinerBuilder
    
    public init(child: Widget, build: ((inout ShadowConatinerBuilder) -> Void)? = nil) {
        self.child = child
        var builder = ShadowConatinerBuilder()
        build?(&builder)
        self.builder = builder
    }

    public func viewProvider(controller: ViewWidgetController<ShadowContainer>) -> TypeSafeViewProvider<ShadowContainer, UIView> {
        return ShadowContainerViewProvider(controller: controller)
    }
}

class ShadowContainerViewProvider: TypeSafeViewProvider<ShadowContainer, UIView> {
    
    class ContainerView: UIView {
        weak var controller: ViewWidgetController<ShadowContainer>?
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            let path = UIBezierPath(roundedRect: bounds,
                                    cornerRadius: controller?.widget.builder.radius ?? 0)
            layer.shadowPath = path.cgPath
        }
    }
    
    private weak var container: ContainerView?
    
    override var children: [Widget]? {
        guard let child = self.controller?.widget.child else {
            return nil
        }
        return [child]
    }
    
    override func view(for widget: ShadowContainer) -> UIView {
        let container = ContainerView(frame: .zero)
        container.backgroundColor = widget.builder.backgroundColor
        container.controller = controller
        container.clipsToBounds = false
        container.directionalLayoutMargins = .zero
        
        if let child = self.children?.first, let subview = controller?.viewForChildWidget(child, at: 0) {
            subview.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(subview)
            container.addConstraintsTo(childView: subview)
        }
        
        self.container = container
        
        applyShadow()
        return container
    }

    override func update(view: UIView, using widget: ShadowContainer) {
        applyShadow()
    }
    
    private func applyShadow() {
        guard let container = self.container, let controller = self.controller else {
            return
        }
        
        container.layer.cornerRadius = controller.widget.builder.radius
        container.layer.shadowColor = controller.widget.builder.shadowColor.cgColor
        container.layer.shadowOpacity = Float(controller.widget.builder.opacity)
        container.layer.shadowRadius = controller.widget.builder.blur
        container.layer.shadowOffset = controller.widget.builder.offset
    }
}
