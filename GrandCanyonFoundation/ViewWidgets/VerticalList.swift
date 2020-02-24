//
//  VerticalList.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/14/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct VerticalList: ViewWidget {
    @WidgetCollectionRef var children: [Widget]
    
    public init(children: [Widget]) {
        self.children = children
    }
    
    public func viewProvider(controller: ViewWidgetController<VerticalList>) -> TypeSafeViewProvider<VerticalList, UIStackView> {
        VerticalListViewProvider(controller: controller)
    }
}

class VerticalListViewProvider: TypeSafeViewProvider<VerticalList, UIStackView> {
    
    override var children: [Widget]? {
        return self.controller?.widget.children
    }
    
    override func view(for widget: VerticalList) -> UIStackView {
        let stack = UIStackView(frame: .zero)
        stack.distribution = .fillEqually
        stack.axis = .vertical
        
        if let children = self.children {
            for child in children {
                guard let subview = controller?.viewForChildWidget(child) else {
                    continue
                }
                
                stack.addArrangedSubview(subview)
            }
        }
        
        return stack
    }

    override func update(view: UIStackView, using widget: VerticalList) { }
}
