//
//  Journey+Mock.swift
//  GrandCanyon
//
//  Created by Karthikkeyan Balan on 2/29/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import Foundation

extension JourneyDetails {
    static var mock: JourneyDetails {
        let group1 = StepGroup(
            title: "Introduction to Management",
            subtitle: "These are some of the first steps toward management in your organization",
            steps: [
                Step(
                    title: "First Time Manager Training",
                    type: "Ariticle",
                    isCompleted: true
                ),
                Step(
                    title: "Code of Conduct Training",
                    type: "Task",
                    isCompleted: false
                ),
                Step(
                    title: "Order Your Company Card",
                    type: "Task",
                    isCompleted: true
                )
            ]
        )
        
        let group2 = StepGroup(
            title: "Tips for New Managers",
            subtitle: nil,
            steps: [
                Step(
                    title: "Public Speaking Tips",
                    type: "Video - 6 minutes",
                    isCompleted: true
                ),
                Step(
                    title: "How to Setup Manager Goals for Managers",
                    type: "External Link",
                    isCompleted: false
                )
            ]
        )
        
        return JourneyDetails(
            title: "Welcome To Journeys",
            description: "Journeys is the place to go during any career and life transition. It’s a place to comfort you by guiding you through exactly what you need to do.",
            stepGroups: [ group1, group2 ]
        )
    }
}
