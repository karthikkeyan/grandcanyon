//
//  ShadowContainer.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct ShadowContainer: ViewWidget {
    let color: UIColor
    let opacity: CGFloat
    let offset: CGSize
    let radius: CGFloat
    let blur: CGFloat
    @WidgetRef var child: Widget
    
    public func viewProvider(controller: ViewWidgetController<ShadowContainer>) -> TypeSafeViewProvider<ShadowContainer, UIView> {
        return ShadowContainerViewProvider(controller: controller)
    }
}

class ShadowContainerViewProvider: TypeSafeViewProvider<ShadowContainer, UIView> {
    
    class ContainerView: UIView {
        weak var controller: ViewWidgetController<ShadowContainer>?
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            let path = UIBezierPath(roundedRect: frame, cornerRadius: controller?.widget.radius ?? 0)
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
        container.controller = controller
        container.clipsToBounds = false
        
        if let child = self.children?.first, let subview = controller?.viewForChildWidget(child, at: 0) {
            container.addSubview(subview)
        }
        
        applyShadow()
        
        self.container = container
        return container
    }

    override func update(view: UIView, using widget: ShadowContainer) {
        applyShadow()
    }
    
    private func applyShadow() {
        guard let container = self.container, let controller = self.controller else {
            return
        }
        
        container.layer.cornerRadius = controller.widget.radius
        container.layer.shadowColor = controller.widget.color.cgColor
        container.layer.shadowOpacity = Float(controller.widget.opacity)
        container.layer.shadowRadius = controller.widget.blur
        container.layer.shadowOffset = controller.widget.offset
    }
}
