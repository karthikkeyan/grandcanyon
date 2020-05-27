//
//  Empty.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/27/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct Empty: ViewWidget {
    public init() { }

    public func viewProvider(
        controller: ViewWidgetController<Empty>
    ) -> TypeSafeViewProvider<Empty, EmptyView> {
        return EmptyViewProvider(controller: controller)
    }
}

class EmptyViewProvider: TypeSafeViewProvider<Empty, EmptyView> {
    override func view(for widget: Empty) -> EmptyView {
        return EmptyView()
    }
    
    override func update(view: UIView, using widget: Empty) { }
}

public class EmptyView: UIView { }
