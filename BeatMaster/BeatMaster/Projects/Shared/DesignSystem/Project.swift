import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "DesignSystem",
    bundleId: .appBundleID(name: ".DesignSystem"),
    product: .staticFramework,
    settings:  .appBaseSetting,
    dependencies: [
        
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"]
)
