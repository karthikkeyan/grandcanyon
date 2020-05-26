//
//  StatefulWidget.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/24/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import Foundation

public protocol StatefulWidget: Widget, Hashable {
    associatedtype State: Hashable
    
    var state: State { get set }
}
