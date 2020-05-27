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
        Table(contentInsets: .init(bottom: .doubleUnit, unit: .zero)) {
            Insets(insets: .init(horizontal: .quadrupleUnit, vertical: .doubleUnit)) {
                HStack(spacing: .doubleUnit) {
                    Text(text: title, font: .pageTitle, color: .white, lineHeight: .quadrupleUnit + .halfUnit)
                    Image(name: IconNames.sitemap)
                        .width(.singleUnit * 7)
                }
            }.height(.singleUnit * 16)
                .background(GradiantBuilder(colors: [.themeBlueDark, .themeBlue]))
            
            Insets(insets: .init(top: .zero, bottom: .singleUnit, horizontal: .doubleUnit)) {
                ShadowContainer {
                    Insets(insets: .doubleUnit) {
                        Text(text: description, font: .body, color: .body, lineHeight: .doubleUnit + .halfUnit)
                    }
                }
            }.background(GradiantBuilder(colors: [.themeBlueDark, .themeBlue], size: .fixedHeight(.quadrupleUnit)))
                .background(.white)
            
            ForEach(self.stepGroups) {
                $0.background(.white)
            }
        }
    }
}

struct StepGroup: PureWidget {
    let title: String
    let subtitle: String?
    let steps: [Step]
    
    var body: Widget {
        Insets(insets: .init(bottom: .singleUnit, unit: .doubleUnit)) {
            ShadowContainer {
                VStack(spacing: .zero) {
                    Insets(insets: .doubleUnit) {
                        TitleSubtitle(
                            title: Text(text: title, font: .sectionHeading, lineHeight: .tripleUnit + .halfUnit),
                            subtitle: subtitle == nil ? nil : Text(text: subtitle!, color: .subtitle, lineHeight: .doubleUnit + .halfUnit)
                        )
                    }
                    
                    ForEach(self.steps) { step in
                        Insets(insets: .doubleUnit) { step }
                    }
                }
            }
        }
    }
}

struct Step: PureWidget {
    let title: String
    let type: String?
    let isRequire: Bool
    let isCompleted: Bool
    
    var body: Widget {
        HStack(spacing: .singleUnit) {
            TitleSubtitle(
                title: Text(text: title, font: .itemTitle, color: .body, lineHeight: .tripleUnit + .halfUnit),
                subtitle: type == nil ? nil : Text(text: type!, color: .subtitle, lineHeight: .doubleUnit + .halfUnit)
            )
            
            Image(name: isCompleted ? IconNames.checked : IconNames.unchecked)
                .width(.tripleUnit)
                .hidden(isRequire)
            
            Image(name: IconNames.chevronRight)
                .width(.tripleUnit)
        }
    }
}
