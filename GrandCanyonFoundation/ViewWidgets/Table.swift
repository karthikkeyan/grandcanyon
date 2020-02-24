//
//  Table.swift
//  GrandCanyonFoundation
//
//  Created by Karthikkeyan Balan on 2/13/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

//public struct Reusable: Widget, Hashable {
//    public let identifier: String
//    public let content: WidgetRef
//}
//
//public struct Table: Widget, Hashable {
//    let rows: [Reusable]
//}
//
///**
// 1. Need to reuse the cells
// 2. Should not recreate the contents of the cells when dequeuing
// 3. Handle duplicate hashValues of widgets, e.g. two row widgets can produce same hashValue given the content of the widget is same
//    - So we need extra information along with the hashValue for a row
//    Solution:
//    ---------
//    We can append the indexPath with the hashValue
// */
//
//private class TableWidgetTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
//
//    var rows: [Reusable] {
//        didSet { refreshCache() }
//    }
//
//    private var renderedRowCache: [AnyHashable: UIView] = [:]
//
//    init(rows: [Reusable]) {
//        self.rows = rows
//
//        super.init(frame: .zero, style: .plain)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return rows.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let widget = rows[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: widget.identifier, for: indexPath)
//
//        if let row = cell as? ListWidgetRow {
//            let hash = widget.asHashable
//            if let cacheView = renderedRowCache[hash] {
//                row.reloadContent(with: cacheView)
//            } else {
//                let view = UIView() // widget.content.asView
//                renderedRowCache[hash] = view
//                row.reloadContent(with: view)
//            }
//        }
//
//        return cell
//    }
//
//    private func refreshCache() {
//        var newRowCache: [AnyHashable: UIView] = [:]
//        for row in rows {
//            let hash = row.asHashable
//            if let existingView = renderedRowCache[row.asHashable] {
//                newRowCache[hash] = existingView
//            }
//        }
//
//        renderedRowCache = newRowCache
//    }
//}
//
//private class ListWidgetRow: UITableViewCell {
//
//    func reloadContent(with view: UIView) {
//        contentView.subviews.forEach { $0.removeFromSuperview() }
//
//        contentView.addSubview(view)
//        contentView.addConstraints(to: view)
//    }
//}
//
//
extension UIView {
    public func addConstraintsTo(childView: UIView) {
        childView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        childView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        childView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
