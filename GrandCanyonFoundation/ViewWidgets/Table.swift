//
//  Table.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/14/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

// MARK: Table
public struct Table: ViewWidget {
    @WidgetCollectionRef fileprivate var rows: [Widget]

    public init(rows: [Widget]) {
        self.rows = rows
    }
    
    public func viewProvider(controller: ViewWidgetController<Table>) -> TypeSafeViewProvider<Table, UITableView> {
        return TableViewProvider(controller: controller)
    }
}

class TableViewProvider: TypeSafeViewProvider<Table, UITableView> {
    
    private let coordinator: TableViewCoordinator
    
    override init(controller: ViewWidgetController<Table>) {
        coordinator = TableViewCoordinator()
        
        super.init(controller: controller)
        
        coordinator.viewProvider = self
    }
    
    override var children: [Widget]? {
        return self.controller?.widget.rows
    }

    override func view(for widget: Table) -> UITableView {
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

    override func update(view: UIScrollView, using widget: Table) { }
}

private class TableViewCoordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var viewProvider: TableViewProvider?
    private var storedCells: [AnyHashable: TableViewCell] = [:]
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewProvider?.children?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = viewProvider?.children?.count ?? 0
        guard count > indexPath.row else {
            assert(false, "Children count mismatch while reloading Table")
            return TableViewCell()
        }
        
        let identifier = "Table-\(indexPath.section)-\(indexPath.row)"
        if let cell = storedCells[identifier] {
            return cell
        } else {
            guard let child = viewProvider?.children?[indexPath.row],
                let subview = viewProvider?.controller?.viewForChildWidget(child, at: indexPath.row) else {
                assert(false, "Children count mismatch while reloading Table")
                return TableViewCell()
            }
            
            let cell = TableViewCell()
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

private class TableViewCell: UITableViewCell {
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
