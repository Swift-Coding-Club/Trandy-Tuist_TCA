import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "Model",
    bundleId: .appBundleID(name: ".Model"),
    product: .staticFramework,
    settings:  .appBaseSetting,
    dependencies: [
        
    ],
    sources: ["Sources/**"]
)
