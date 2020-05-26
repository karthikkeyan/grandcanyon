//
//  WidgetController.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/14/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

// MARK: WidgetController
public protocol WidgetController: class {
    var parent: WidgetController? { get set }
    var child: WidgetController? { get set }
    var widgetAsHashable: String { get }
    var body: Widget { get }
    
    var model: Widget { get }

    func viewForMount(parent: WidgetController?) -> UIView
    func viewForChildWidget(_ childWidget: Widget, at index: Int) -> UIView?
    func willMount()
    func didMount()
}

public extension WidgetController {
    func willMount() { }
    func didMount() { }
    
    func setNeedsUpate() { }
}

