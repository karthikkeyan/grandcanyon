//
//  View.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Bala Sundaram on 5/24/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public protocol View {
    associatedtype Body: View
    var body: Self.Body { get }
}

extension View {
    var controller: Controller<Self> {
        return Controller { self }
    }
}

public protocol PhysicalViewRepresentable: View where Body == Never {
    associatedtype PhysicalView: UIView
    
    func make() -> PhysicalView
    func update(view: PhysicalView, state: Self)
}

class Controller<Content> {
    var view: Content
    var uiview: UIView? = nil
    
    init(_ content: () -> Content) {
        self.view = content()
    }
}

public struct Label: PhysicalViewRepresentable {
    public typealias Body = Never
    public typealias PhysicalView = UILabel

    let text: String
    
    public func make() -> PhysicalView {
        return UILabel()
    }
    
    public func update(view: PhysicalView, state: Self) {
        
    }
}

extension View where Self.Body == Never {
    public var body: Never {
        fatalError("Something very, very bad happened")
    }
}

extension Never: View {
    public typealias Body = Never
}
