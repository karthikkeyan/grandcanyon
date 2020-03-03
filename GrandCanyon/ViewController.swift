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
        
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.2
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: .halfUnit)
        
        let model = JourneyDetails.mock
        let engine = WidgetRenderingEngine(root: model)
        let list = engine.render()
        list.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(list)

        NSLayoutConstraint.activate([
            list.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            list.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            list.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
