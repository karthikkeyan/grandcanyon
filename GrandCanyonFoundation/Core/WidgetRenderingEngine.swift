//
//  WidgetRenderingEngine.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/13/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public class WidgetRenderingEngine {
    let rootController: WidgetControllerInterface

    public init(root: Widget) {
        rootController = root.controller()
    }

    public func render() -> UIView {
        defer { rootController.didMount() }
        rootController.willMount()
        return rootController.viewForMount(parent: nil)
    }
}
