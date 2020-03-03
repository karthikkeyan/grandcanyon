//
//  Journey.swift
//  GrandCanyon
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import GrandCanyonFoundation
import UIKit

struct JourneyDetails: PureWidget {
    let stepGroups: [StepGroup]
    
    func build() -> Widget {
        return VerticalList(children: stepGroups)
    }
}

struct StepGroup: PureWidget {
    let title: String
    let subtitle: String?
    let steps: [Step]
    
    func build() -> Widget {
        var children: [Widget] = []
        if let subtitle = self.subtitle {
            children.append(TitleSubtitle(title: Text(text: title, font: .sectionHeading), subtitle: Text(text: subtitle, color: .subtitle)))
        } else {
            children.append(TitleSubtitle(title: Text(text: title, font: .sectionHeading), subtitle: nil))
        }
        
        children.append(contentsOf: steps)
        let list = VerticalStack(spacing: .tripleUnit, children: children)
        let insets = Insets(insets: UIEdgeInsets(horizontal: .doubleUnit, vertical: .tripleUnit), child: list)
        return ShadowContainer(child: insets)
    }
}

struct Step: PureWidget {
    let title: String
    let type: String?
    let isCompleted: Bool
    
    func build() -> Widget {
        let sizedImage = Image(name: IconNames.unchecked)
        let text = TitleSubtitle(title: Text(text: title, font: .itemTitle, color: .themeBlue),
                                 subtitle: Text(text: title, color: .subtitle))
        return HorizontalStack(distribution: .equalSpacing, alignment: .center, spacing: .singleUnit, children: [text, sizedImage])
    }
}

struct TitleSubtitle: PureWidget {
    let title: Text
    let subtitle: Text?
    
    func build() -> Widget {
        if let subtitle = self.subtitle {
            return VerticalStack(spacing: .halfUnit, children: [ title, subtitle ])
        } else {
            return VerticalStack(spacing: .halfUnit, children: [ title ])
        }
    }
}
