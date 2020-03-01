import UIKit
import GrandCanyonFoundation
import PlaygroundSupport

//extension UIView {
//    func snapCorners(parent: UIView) {
//        NSLayoutConstraint.activate([
//            leadingAnchor.constraint(equalTo: parent.leadingAnchor),
//            trailingAnchor.constraint(equalTo: parent.trailingAnchor),
//            topAnchor.constraint(equalTo: parent.topAnchor),
//            bottomAnchor.constraint(equalTo: parent.bottomAnchor)
//        ])
//    }
//}
//
//class WidgetViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//    }
//}
//
//let textWidget = Text(text: "Hello World")
//
//let label = WidgetRenderingEngine(root: textWidget).render()
//label.translatesAutoresizingMaskIntoConstraints = false
//let controller = WidgetViewController()
//controller.view.addSubview(label)
//label.snapCorners(parent: controller.view)
//PlaygroundPage.current.liveView = controller
//
//print(["hello", "world"].hashValue)
//print(["world", "hello"].hashValue)
//print(["hello", "world"].hashValue)
//print(["world", "hello"].hashValue)


struct Journey: Hashable {
    let title: String
    let steps: [Group]
}

struct Group: Hashable {
    let title: String
    let steps: [Step]
}

struct Step: Hashable {
    let title: String
    let type: String
}
