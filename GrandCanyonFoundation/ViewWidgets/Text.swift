//
//  Text.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/13/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct Text: ViewWidget {
    public let text: String?
    public let font: UIFont
    public let color: UIColor
    public let alignment: NSTextAlignment
    public let lineSpacing: CGFloat
    public let lineHeight: CGFloat?
    
    public init(text: String?,
                font: UIFont = .systemFont(ofSize: 14, weight: .regular),
                color: UIColor = .black,
                alignment: NSTextAlignment = .left,
                lineSpacing: CGFloat = .zero,
                lineHeight: CGFloat? = nil) {
        self.text = text
        self.font = font
        self.color = color
        self.alignment = alignment
        self.lineSpacing = lineSpacing
        self.lineHeight = lineHeight
    }
    
    public func viewProvider(controller: ViewWidgetController<Text>) -> TypeSafeViewProvider<Text, UILabel> {
        return TextViewProvider(controller: controller)
    }
}

class TextViewProvider: TypeSafeViewProvider<Text, UILabel> {
    override func view(for widget: Text) -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        update(view: label, using: widget)
        return label
    }

    override func update(view: UILabel, using widget: Text) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = widget.lineSpacing
        paragraphStyle.alignment = widget.alignment
        if let lineHeight = widget.lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        }
        
        let _text = widget.text ?? ""
        view.attributedText = NSMutableAttributedString(string: _text, attributes: [
            .font: widget.font,
            .foregroundColor: widget.color,
            .paragraphStyle: paragraphStyle
        ])
    }
}
