# Grand Canyon

This is my side project that I created for fun to understand how SwiftUI library works. The grandcanyon library is a declarative UI library built on top of UIKit.

Swift's `@functionBuilder` and `@propertyWrapper ` enabled the posibility of writting a declarative code everywhere. 

Here's an example code snippet that looks like SwiftUI code but it is completely built using GrandCanyon library,

```swift
struct DetailView: PureWidget {
    let title: String
    let description: String
    let stepGroups: [StepGroup]
    
    var body: Widget {
        Table(contentInsets: .init(bottom: .doubleUnit, unit: .zero)) {
            Insets(insets: .init(horizontal: .quadrupleUnit, vertical: .doubleUnit)) {
                HStack(spacing: .doubleUnit) {
                    Text(text: title, font: .pageTitle, color: .white, lineHeight: .pageHeaderLineHeight)
                    Image(name: IconNames.sitemap)
                        .width(.headerIconWidth)
                }
            }.height(.headerHeight)
                .background(GradiantBuilder(colors: [.themeBlueDark, .themeBlue]))
            
            Insets(insets: .init(top: .zero, bottom: .singleUnit, horizontal: .doubleUnit)) {
                ShadowContainer {
                    Insets(insets: .doubleUnit) {
                        Text(text: description, font: .body, color: .dismissableText, lineHeight: .bodyLineHeight)
                    }
                }
            }.background(GradiantBuilder(colors: [.themeBlueDark, .themeBlue], size: .fixedHeight(.quadrupleUnit)))
            
            ForEach(self.stepGroups) { $0 }
        }.background(.tableBackground)
    }
}
```

Hit me up if you find this interesting or if you have any questions.

> Note: This library is not built completely, but I have created few views those are building blocks to create a static ui. Again this is just my fun project to understand how swift ui works.