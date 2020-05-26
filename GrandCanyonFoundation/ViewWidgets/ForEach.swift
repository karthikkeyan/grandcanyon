//
//  ForEach.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/23/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct ForEach: ViewWidget {
    internal let id = UUID()
    internal let widgets: [Widget]
    
    public init<T>(_ items: [T], _ iteration: (T) -> Widget) {
        widgets = items.map(iteration)
    }
    
    public func viewProvider(
        controller: ViewWidgetController<ForEach>
    ) -> TypeSafeViewProvider<ForEach, UIView> {
        return TupleViewProvider(controller: controller)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
