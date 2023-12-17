import Foundation

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "HeardItBefore",
    bundleId: .appBundleID(name: ".HeardItBefore"),
    product: .app,
    settings:  .settings(),
    dependencies: [
        .project(target: "HelloFeature", path: .relativeToRoot("Projects/Feature/HelloFeature"))
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .file(path: "../../Support/Info.plist")
)
