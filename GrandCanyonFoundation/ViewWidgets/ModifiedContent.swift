//
//  ModifiedContent.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/26/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct ModifiedContent: ViewWidget {
    private(set) var modifiers: [Modifier]
    @WidgetRef var child: Widget

    public init(modifiers: [Modifier] = [], @WidgetBuilder body: () -> Widget) {
        self.child = body()
        self.modifiers = modifiers
    }
    
    public func viewProvider(
        controller: ViewWidgetController<ModifiedContent>
    ) -> TypeSafeViewProvider<ModifiedContent, ModifiedContentView> {
        return ModifiedContentViewProvider(controller: controller)
    }
    
    func byAdding(modifier: Modifier) -> ModifiedContent {
        var newContent = self
        newContent.modifiers.append(modifier)
        return newContent
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(child.asHashable)
        modifiers.forEach { hasher.combine($0.asHashable) }
    }
}

class ModifiedContentViewProvider: TypeSafeViewProvider<ModifiedContent, ModifiedContentView> {
    override var children: [Widget]? {
        guard let child = self.controller?.widget.child else {
            return nil
        }
        return [child]
    }
    
    override func view(for widget: ModifiedContent) -> ModifiedContentView {
        let view = ModifiedContentView(frame: .zero)
        
        if let child = children?.first,
            let contentView = self.controller?.viewForChildWidget(child, at: 0) {
            view.addSubview(contentView)
            contentView.clipEdges(to: view)
            
            controller?.widget.modifiers.forEach {
                contentView.apply(modifier: $0)
            }
        }
        
        return view
    }
    
    override func update(view: ModifiedContentView, using widget: ModifiedContent) { }
}

public class ModifiedContentView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal extension Widget {
    func modifiedContent(using modifier: Modifier) -> ModifiedContent {
        if let content = self as? ModifiedContent {
            return content.byAdding(modifier: modifier)
        } else {
            return ModifiedContent(modifiers: [modifier], body: { self })
        }
    }
}


extension UIView {
    func apply(modifier: Modifier) {
        if let _modifier = modifier as? SizeModifier {
            apply(modifier: _modifier)
        } else if let _modifier = modifier as? StyleModifier {
            apply(modifier: _modifier)
        } else if let _modifier = modifier as? OffsetModifier {
            apply(modifier: _modifier)
        }
    }
}

// MARK: - SizeModifer

extension UIView {
    func apply(modifier: SizeModifier) {
        if let height = modifier.height {
            clipEdges(to: self, sides: [.height(height)])
        }
        
        if let width = modifier.width {
            clipEdges(to: self, sides: [.width(width)])
        }
    }
}

// MARK: - StyleModifier

extension UIView {
    func apply(modifier: StyleModifier) {
        if let hide = modifier.isHidden {
            isHidden = hide
        }
        
        if let background = modifier.background {
            backgroundColor = background
        }
    }
}


extension UIView {
    func apply(modifier: OffsetModifier) {
        let top = findConstraint(layoutAttribute: .top)
        top?.constant = modifier.y
        
        let leading = findConstraint(layoutAttribute: .leading)
        leading?.constant = modifier.x
        
        layer.zPosition = modifier.z
    }
    
    private func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
        }
        return nil
    }

    private func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
            let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
            let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
            return firstItemMatch || secondItemMatch
        }
        return false
    }
}
