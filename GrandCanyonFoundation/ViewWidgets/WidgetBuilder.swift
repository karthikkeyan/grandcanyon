//
//  WidgetBuilder.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/22/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

@_functionBuilder
public struct WidgetBuilder {
    public static func buildBlock(_ widgets: Widget...) -> Widget {
        return TupleWidget(widgets: widgets)
    }
    
    public static func buildBlock(_ widget: Widget) -> Widget {
        return widget
    }
    
    public static func buildEither(first: Widget) -> Widget {
        return first
    }
    
    public static func buildEither(second: Widget) -> Widget {
        return second
    }

    public static func buildOptional(_ widget: Widget?) -> Widget? {
        return widget
    }
}
