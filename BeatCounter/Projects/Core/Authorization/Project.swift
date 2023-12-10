import ProjectDescription
import MyPlugin

// Local plugin loaded

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.makeAppModule(
    bundleId: "Authorization",
    product: .staticFramework,
    settings: .settings()
)
