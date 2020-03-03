//
//  Image.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 3/3/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct Image: ViewWidget {
    let name: String
    let scale: UIView.ContentMode
    let tintColor: UIColor?
    
    public init(name: String,
                scale: UIView.ContentMode = .scaleAspectFit,
                tintColor: UIColor? = nil) {
        self.name = name
        self.scale = scale
        self.tintColor = tintColor
    }

    public func viewProvider(controller: ViewWidgetController<Image>) -> TypeSafeViewProvider<Image, UIImageView> {
        return ImageViewProvider(controller: controller)
    }
}

class ImageViewProvider: TypeSafeViewProvider<Image, UIImageView> {
    private weak var imageView: UIImageView?
    
    override var children: [Widget]? { return nil }
    
    override func view(for widget: Image) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        
        let name = widget.name
        imageView.contentMode = widget.scale
        imageView.image = UIImage(named: name)
        if let tintColor = widget.tintColor {
            imageView.tintColor = tintColor
        }
        
        self.imageView = imageView
        return imageView
    }

    override func update(view: UIView, using widget: Image) {
        imageView?.image = UIImage(named: widget.name)
    }
}
