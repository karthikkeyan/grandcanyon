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
    @OptionalWidgetRef fileprivate var background: Widget? = nil
    @OptionalWidgetRef fileprivate var header: Widget? = nil
    @OptionalWidgetRef fileprivate var footer: Widget? = nil
    
    let contentInsets: UIEdgeInsets

    public init(contentInsets: UIEdgeInsets = .zero, @WidgetBuilder rows: () -> Widget) {
        self.contentInsets = contentInsets
        
        let content = rows()
        if let tuple = content as? TupleWidget {
            self.rows = tuple.widgets
        } else {
            self.rows = [content]
        }
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
        view.contentInset = widget.contentInsets
        view.backgroundColor = .clear
        
        if let background = controller?.widget.background {
            view.backgroundView = controller?.viewForChildWidget(background, at: children?.count ?? Int.min)
        }
        
        if let header = controller?.widget.header {
            view.tableHeaderView = controller?.viewForChildWidget(header, at: children?.count ?? -1)
        }
        
        if let footer = controller?.widget.footer {
            view.tableFooterView = controller?.viewForChildWidget(footer, at: children?.count ?? -2)
        }
        
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContentView() {
        view?.removeFromSuperview()
        
        guard let newView = view else { return }
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newView)
        newView.clipEdges(to: contentView)
    }
}


public extension Table {
    func background(@WidgetBuilder body: () -> Widget) -> Table {
        var table = self
        let content = body()
        if let tuple = content as? TupleWidget {
            table.background = tuple.widgets.first
        } else {
            table.background = content
        }
        return table
    }
    
    func header(@WidgetBuilder body: () -> Widget) -> Table {
        var table = self
        let content = body()
        if let tuple = content as? TupleWidget {
            table.header = tuple.widgets.first
        } else {
            table.header = content
        }
        return table
    }
    
    func footer(@WidgetBuilder body: () -> Widget) -> Table {
        var table = self
        let content = body()
        if let tuple = content as? TupleWidget {
            table.footer = tuple.widgets.first
        } else {
            table.footer = content
        }
        return table
    }
}
