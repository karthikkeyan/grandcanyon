//
//  WidgetRenderingEngine.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/13/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public class WidgetRenderingEngine {
    let rootController: WidgetController

    public init(root: Widget) {
        rootController = root.controller()
    }

    public func render() -> WidgetHostView {
        defer { rootController.didMount() }
        rootController.willMount()
        let renderedView = rootController.viewForMount(parent: nil)
        return WidgetHostView(view: renderedView, controller: rootController)
    }
}

public class WidgetHostView: UIView {
    private let rootView: UIView
    private let controller: WidgetController
    
    init(view: UIView, controller: WidgetController) {
        self.rootView = view
        self.controller = controller
        
        super.init(frame: .zero)
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(insets: .zero)
        rootView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rootView)
        addConstraintsTo(childView: rootView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
