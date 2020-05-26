//
//  Geometry.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/23/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct Geometry: ViewWidget {
    public var state: CGRect = .zero

    private let id = UUID()
    fileprivate let _content: (CGRect) -> Widget
    
    public init(@WidgetBuilder body: @escaping (CGRect) -> Widget) {
        self._content = body
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public func viewProvider(
        controller: ViewWidgetController<Geometry>
    ) -> TypeSafeViewProvider<Geometry, GeometryView> {
        return GeometryViewProvider(controller: controller)
    }
}

class GeometryViewProvider: TypeSafeViewProvider<Geometry, GeometryView> {
    fileprivate var bounds: CGRect = .zero
    
    override func view(for widget: Geometry) -> GeometryView {
        let view = GeometryView(frame: .zero)
        view.directionalLayoutMargins = .zero
        
        if let controller = self.controller {
            @WidgetBuilder var content: Widget {
                controller.widget._content(bounds)
            }
            
            if let subview = controller.viewForChildWidget(content, at: 0) {
                view.addSubview(subview)
                subview.translatesAutoresizingMaskIntoConstraints = false
                subview.clipMargins(to: view)
            }
        }
        
        return view
    }
    
    override func update(view: GeometryView, using widget: Geometry) {
        if let controller = self.controller {
            @WidgetBuilder var content: Widget {
                controller.widget._content(bounds)
            }

            let subview = controller.viewForChildWidget(content, at: 0)
        }
    }
    
    fileprivate func update(bounds: CGRect) {
        self.bounds = bounds
    }
}

public class GeometryView: UIView {
    weak var controller: ViewWidgetController<Geometry>?
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard var geometry = controller?.widget else { return }
        geometry.state = bounds
    }
}
