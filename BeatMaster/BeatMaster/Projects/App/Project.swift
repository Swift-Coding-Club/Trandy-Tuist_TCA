import ProjectDescription
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "BeatMaster",
    bundleId: .mainBundleID(),
    product: .app,
    packages: [],
    settings: .appMainSetting,
    dependencies: [
        .Core(implements: .Core),
        .Networking(implements: .Networkings),
        .Shared(implements: .Shareds)
        
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist"),
    entitlements: .file(path: "Entitlements/BeatMaster.entitlements")
    

)
