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
    
    public init(text: String?,
                font: UIFont = .systemFont(ofSize: 14, weight: .regular),
                color: UIColor = .black,
                alignment: NSTextAlignment = .left) {
        self.text = text
        self.font = font
        self.color = color
        self.alignment = alignment
    }
    
    public func viewProvider(controller: ViewWidgetController<Text>) -> TypeSafeViewProvider<Text, UILabel> {
        return TextViewProvider(controller: controller)
    }
}

class TextViewProvider: TypeSafeViewProvider<Text, UILabel> {
    override func view(for widget: Text) -> UILabel {
        let label = UILabel(frame: .zero)
        label.font = widget.font
        label.textColor = widget.color
        label.textAlignment = widget.alignment
        label.text = widget.text
        label.numberOfLines = 0
        return label
    }

    override func update(view: UILabel, using widget: Text) {
        view.font = widget.font
        view.textColor = widget.color
        view.textAlignment = widget.alignment
        view.text = widget.text
    }
}
