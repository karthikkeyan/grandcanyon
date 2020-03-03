//
//  TitleSubtitle.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 3/3/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import Foundation

public struct TitleSubtitle: PureWidget {
    let title: Text
    let subtitle: Text?
    
    public init(title: Text, subtitle: Text?) {
        self.title = title
        self.subtitle = subtitle
    }
    
    public func build() -> Widget {
        if let subtitle = self.subtitle {
            return VerticalStack(spacing: .halfUnit, children: [ title, subtitle ])
        } else {
            return VerticalStack(spacing: .halfUnit, children: [ title ])
        }
    }
}
