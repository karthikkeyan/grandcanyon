//
//  Gradiant.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/26/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct GradiantBuilder: Hashable {
    public enum Size: Hashable {
        case full
        case fixedHeight(CGFloat)
    }
    
    public let colors: [UIColor]
    public let size: Size
    
    public init(colors: [UIColor], size: Size = .full) {
        self.colors = colors
        self.size = size
    }
}

public struct Gradiant: ViewWidget {
    let builder: GradiantBuilder
    
    @WidgetRef var child: Widget
    public init(builder: GradiantBuilder, @WidgetBuilder body: () -> Widget) {
        self.builder = builder
        self.child = body()
    }
    
    public func viewProvider(
        controller: ViewWidgetController<Gradiant>
    ) -> TypeSafeViewProvider<Gradiant, GradiantView> {
        return GradiantViewProvider(controller: controller)
    }
}

class GradiantViewProvider: TypeSafeViewProvider<Gradiant, GradiantView> {
    override var children: [Widget]? {
        guard let child = self.controller?.widget.child else {
            return nil
        }
        return [child]
    }
    
    override func view(for widget: Gradiant) -> GradiantView {
        let view = GradiantView(colors: widget.builder.colors)
        view.size = widget.builder.size
        
        if let child = children?.first,
            let contentView = self.controller?.viewForChildWidget(child, at: 0) {
            view.addSubview(contentView)
            contentView.clipEdges(to: view)
        }
        
        return view
    }
    
    override func update(view: GradiantView, using widget: Gradiant) {
        view.colors = widget.builder.colors
        view.size = widget.builder.size
    }
}

public class GradiantView: UIView {
    public var colors: [UIColor] {
        didSet {
            gradiantLayer.colors = colors.map { $0.cgColor }
            setNeedsDisplay()
        }
    }
    
    public var size: GradiantBuilder.Size = .full {
        didSet {
            setNeedsLayout()
        }
    }
    
    private lazy var gradiantLayer = CAGradientLayer()
    
    public init(colors: [UIColor]) {
        self.colors = colors

        super.init(frame: .zero)

        layer.addSublayer(gradiantLayer)
        gradiantLayer.colors = colors.map { $0.cgColor }
        gradiantLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradiantLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var newBounds = bounds
        switch size {
        case .fixedHeight(let height):
            newBounds.size.height = height
        case .full:
            break
        }

        gradiantLayer.frame = newBounds
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
