import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "Shareds",
    bundleId: .appBundleID(name: ".Shareds"),
    product: .staticFramework,
    settings: .appBaseSetting,
    dependencies: [
        .Shared(implements: .Constants),
        .Shared(implements: .DesignSystem),
        .Shared(implements: .ThirdParty)
    ],
    sources: ["Sources/**"]
)
