//
//  VerticalList.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/14/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

// MARK: VerticalList
public struct VerticalList: ViewWidget {
    let spacing: CGFloat
    @WidgetCollectionRef var children: [Widget]
    
    public init(spacing: CGFloat = 0, children: [Widget]) {
        self.spacing = spacing
        self.children = children
    }
    
    public func viewProvider(controller: ViewWidgetController<VerticalList>) -> TypeSafeViewProvider<VerticalList, UITableView> {
        return VerticalListViewProvider(controller: controller)
    }
}

class VerticalListViewProvider: TypeSafeViewProvider<VerticalList, UITableView> {
    
    private let coordinator: VerticalListCoordinator
    
    override init(controller: ViewWidgetController<VerticalList>) {
        coordinator = VerticalListCoordinator()
        
        super.init(controller: controller)
        
        coordinator.viewProvider = self
    }
    
    override var children: [Widget]? {
        return self.controller?.widget.children
    }

    override func view(for widget: VerticalList) -> UITableView {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier")
        view.allowsSelection = false
        view.separatorStyle = .none
        view.estimatedRowHeight = .quadrupleUnit
        view.rowHeight = UITableView.automaticDimension
        view.dataSource = coordinator
        view.delegate = coordinator        
        return view
    }

    override func update(view: UIScrollView, using widget: VerticalList) { }
}

private class VerticalListCoordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var viewProvider: VerticalListViewProvider?
    private var storedCells: [AnyHashable: VerticalListCell] = [:]
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewProvider?.children?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = viewProvider?.children?.count ?? 0
        guard count > indexPath.row else {
            assert(false, "Children count mismatch while reloading VerticalList")
            return VerticalListCell()
        }
        
        let identifier = "VerticalList-\(indexPath.section)-\(indexPath.row)"
        if let cell = storedCells[identifier] {
            return cell
        } else {
            guard let child = viewProvider?.children?[indexPath.row],
                let subview = viewProvider?.controller?.viewForChildWidget(child, at: indexPath.row) else {
                assert(false, "Children count mismatch while reloading VerticalList")
                return VerticalListCell()
            }
            
            let cell = VerticalListCell()
            cell.view = subview
            storedCells[identifier] = cell
            return cell
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

private class VerticalListCell: UITableViewCell {
    var view: UIView? {
        didSet { updateContentView() }
    }
    
    func updateContentView() {
        view?.removeFromSuperview()
        
        guard let newView = view else { return }
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newView)
        contentView.addConstraintsTo(childView: newView)
    }
}
