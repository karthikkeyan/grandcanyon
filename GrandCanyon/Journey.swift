//
//  Journey.swift
//  GrandCanyon
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import GrandCanyonFoundation

struct JourneyDetails: PureWidget {
    let stepGroups: [StepGroup]
    
    func build() -> Widget {
        return VerticalList(spacing: .tripleUnit, children: stepGroups)
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
        return VerticalStack(spacing: .doubleUnit, children: children)
    }
}

struct Step: PureWidget {
    let title: String
    let type: String?
    let isCompleted: Bool
    
    func build() -> Widget {
        return TitleSubtitle(title: Text(text: title, font: .itemTitle, color: .themeBlue),
                             subtitle: Text(text: title, color: .subtitle))
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
