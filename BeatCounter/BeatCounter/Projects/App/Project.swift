import ProjectDescription
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.makeAppModule(
    bundleId: .mainBundleID(),
    product: .app,
    packages: [],
    settings: .settings(),
    dependencies: [
        .Core(implements: .Core),
        .Networking(implements: .Networkings),
        .Shared(implements: .Shareds)
        
       
    
    
    ],
    sources: ["Sources/**"]
)
