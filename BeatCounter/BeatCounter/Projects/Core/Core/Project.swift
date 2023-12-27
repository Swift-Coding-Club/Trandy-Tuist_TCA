import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "Core",
    bundleId: .appBundleID(name: ".Core"),
    product: .staticFramework,
    settings:  .settings(),
    dependencies: [
        .Core(implements: .Authorization),
        .Feature(implements: .Auth),
        .Feature(implements: .BPMCounter),
        .Feature(implements: .Metronome),
    ],
    sources: ["Sources/**"]
)
