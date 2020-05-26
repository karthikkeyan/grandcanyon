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
        rootController = WidgetRenderingEngine.controllerTree(root, parent: nil)
    }

    public func render() -> WidgetHostView {
        defer { rootController.didMount() }
        rootController.willMount()
        
        var controller: WidgetController? = rootController
        while let _controller = controller, _controller.model.kind != .view {
            controller = _controller.child
        }

        let viewController = controller ?? EmptyWidget().controller()
        let renderedView = viewController.viewForMount(parent: nil)
        return WidgetHostView(view: renderedView, controller: viewController)
    }
    
    // MARK: - Private Methods

    static private func controllerTree(_ node: Widget, parent: WidgetController?) -> WidgetController {
        let controller = node.controller()
        controller.parent = parent

        switch node.kind {
        case .pure, .unknown:
            controller.child = controllerTree(node.body, parent: controller)
        case .view:
            break
        }

        return controller
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

struct EmptyWidget: ViewWidget {
    func viewProvider(
        controller: ViewWidgetController<EmptyWidget>
    ) -> TypeSafeViewProvider<EmptyWidget, UIView> {
        return TypeSafeViewProvider(controller: controller)
    }
}

extension Widget {
    func viewController() -> Controller<Self> {
        return Controller { self }
    }
}
