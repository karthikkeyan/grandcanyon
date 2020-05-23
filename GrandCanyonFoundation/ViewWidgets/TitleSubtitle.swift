//
//  TitleSubtitle.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 3/3/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import Foundation

public struct TitleSubtitle: PureWidget {
    private let title: Text
    private let subtitle: Text?
    
    public init(title: Text, subtitle: Text?) {
        self.title = title
        self.subtitle = subtitle
    }
    
    public var body: Widget {
        VerticalStack(spacing: .halfUnit) {
            if subtitle != nil {
                title
                subtitle!
            } else {
                title
            }
        }
    }
}
