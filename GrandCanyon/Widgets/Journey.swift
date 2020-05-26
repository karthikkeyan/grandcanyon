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
    let title: String
    let description: String
    let stepGroups: [StepGroup]
    
    var body: Widget {
        Table {
            Geometry { size in
                Insets(insets: .doubleUnit) {
                    Text(text: "Hello World")
                }
            }
            
//            ForEach(self.stepGroups) { $0 }
        }
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
                    TitleSubtitle(
                        title: Text(text: title, font: .sectionHeading),
                        subtitle: subtitle == nil ? nil : Text(text: subtitle!, color: .subtitle)
                    )

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
        HorizontalStack(distribution: .equalCentering, alignment: .center, spacing: .singleUnit) {
            TitleSubtitle(
                title: Text(text: title, font: .itemTitle, color: .themeBlue),
                subtitle: type == nil ? nil : Text(text: type!, color: .subtitle)
            )
            
            Image(name: IconNames.unchecked)
        }
    }
}
