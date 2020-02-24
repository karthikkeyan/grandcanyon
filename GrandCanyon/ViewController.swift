//
//  ViewController.swift
//  GrandCanyon
//
//  Created by Karthikkeyan Balan on 2/13/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit
import GrandCanyonFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let children: [Text] = [
            Text(text: "Hello"),
            Text(text: "World"),
            Text(text: "Karthik")
        ]
        
        let widget = VerticalList(children: children)
        let engine = WidgetRenderingEngine(root: widget)
        let list = engine.render()
        list.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(list)
        
        NSLayoutConstraint.activate([
            list.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            list.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
