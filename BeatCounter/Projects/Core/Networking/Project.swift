import ProjectDescription
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.makeAppModule(
    bundleId: "Networking",
    product: .staticFramework,
    settings: .settings(),
    dependencies: []
)
