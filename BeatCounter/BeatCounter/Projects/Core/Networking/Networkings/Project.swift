import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
name: "Networkings",
bundleId: .appBundleID(name: ".Networkings"),
product: .staticFramework,
settings:  .settings(),
dependencies: [
    .Networking(implements: .Model),
    .Networking(implements: .Service)
],
sources: ["Sources/**"]
)
