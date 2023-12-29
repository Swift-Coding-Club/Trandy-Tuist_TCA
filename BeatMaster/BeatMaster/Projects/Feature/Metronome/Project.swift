import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "Metronome",
    bundleId: .appBundleID(name: ".Metronome"),
    product: .staticFramework,
    settings:  .appBaseSetting,
    dependencies: [
        
    ],
    sources: ["Sources/**"]
)
