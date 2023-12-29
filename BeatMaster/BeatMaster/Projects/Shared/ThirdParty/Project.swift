import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "ThirdParty",
    bundleId: .appBundleID(name: ".ThirdParty"),
    product: .staticFramework,
    settings:  .appBaseSetting,
    dependencies: [
        .package(product: "ComposableArchitecture", type: .macro)
        
        
    ],
    sources: ["Sources/**"]
)
