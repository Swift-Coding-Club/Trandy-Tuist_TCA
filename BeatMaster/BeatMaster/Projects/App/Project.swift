//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 1/6/24.
//

import ProjectDescription
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: Project.Environment.appName,
    bundleId: .mainBundleID(),
    product: .app,
    settings: .appMainSetting,
    dependencies: [
        .Core(implements: .Core),
        .Shared(implements: .Shareds),
        .Networking(implements: .Networkings)
    
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist"),
    entitlements: .file(path: "Entitlements/BeatMaster.entitlements")
    
)

