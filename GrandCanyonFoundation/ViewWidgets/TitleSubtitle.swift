//
//  TitleSubtitle.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 3/3/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct TitleSubtitle: PureWidget {
    private let title: Text
    private let subtitle: Text?
    private let spacing: CGFloat
    
    public init(title: Text, subtitle: Text?, spacing: CGFloat = .halfUnit) {
        self.title = title
        self.subtitle = subtitle
        self.spacing = spacing
    }
    
    public var body: Widget {
        VStack(spacing: spacing) {
            if subtitle != nil {
                title
                subtitle!
            } else {
                title
            }
        }
    }
}
