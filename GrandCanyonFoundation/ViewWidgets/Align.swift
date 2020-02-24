//
//  Align.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/17/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

struct Align: ViewWidget {
    @WidgetRef var child: Widget
    
    func viewProvider(controller: ViewWidgetController<Align>) -> TypeSafeViewProvider<Align, UIView> {
        return AlignViewProvider(controller: controller)
    }
}

class AlignViewProvider: TypeSafeViewProvider<Align, UIView> {
    override func view(for widget: Align) -> UIView {
        return UIView(frame: .zero)
    }
    
    override func update(view: UIView, using widget: Align) { }
}
