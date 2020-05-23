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
    
    var body: Widget {
        Table(rows: stepGroups)
    }
}

struct StepGroup: PureWidget {
    let title: String
    let subtitle: String?
    let steps: [Step]
    
    var body: Widget {
        ShadowContainer {
            Insets(insets: .init(horizontal: .doubleUnit, vertical: .tripleUnit)) {
                VerticalStack(spacing: .tripleUnit) {
                    if subtitle != nil {
                        TitleSubtitle(
                            title: Text(text: title, font: .sectionHeading),
                            subtitle: Text(text: subtitle!, color: .subtitle)
                        )
                    } else {
                        TitleSubtitle(
                            title: Text(text: title, font: .sectionHeading),
                            subtitle: nil
                        )
                    }

                    ForEach(self.steps) { $0 }
                }
            }
        }
    }
}

struct Step: PureWidget {
    let title: String
    let type: String?
    let isCompleted: Bool
    
    var body: Widget {
        HorizontalStack(distribution: .equalSpacing, alignment: .center, spacing: .singleUnit) {
            if type != nil {
                TitleSubtitle(
                    title: Text(text: title, font: .itemTitle, color: .themeBlue),
                    subtitle: Text(text: type!, color: .subtitle)
                )
            } else {
                TitleSubtitle(
                    title: Text(text: title, font: .itemTitle, color: .themeBlue),
                    subtitle: nil
                )
            }
            
            Image(name: IconNames.unchecked)
        }
    }
}
