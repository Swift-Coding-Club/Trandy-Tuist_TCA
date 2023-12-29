import ProjectDescription
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")
// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.makeAppModule(
    name: "Authorization",
    bundleId: .appBundleID(name: ".Authorization"),
    product: .staticFramework,
    settings: .appBaseSetting,
    dependencies: [
    
    
    ],
    sources: ["Sources/**"]
)
