import Foundation

import ProjectDescription

let appName: Template.Attribute = .required("name")
let appPlatform: Template.Attribute = .optional("platform", default: "ios")

let template = Template(
    description: "New App module template",
    attributes: [
        appName,
        appPlatform
    ],
    items: AppTemplate.allCases.map { $0.item }
)

enum AppTemplate: CaseIterable {
    case app
    case contentView
    case project
    case launchScreen
    
    var item: Template.Item {
        switch self {
        case .app:
            return .file(path: .appBasePath + "/Sources/\(appName)App.swift", templatePath: "App.stencil")
        case .contentView:
            return .file(path: .appBasePath + "/Sources/ContentView.swift", templatePath: "ContentView.stencil")
        case .project:
            return .file(path: .appBasePath + "/Project.swift", templatePath: "Project.stencil")
        case .launchScreen:
            return .file(path: .appBasePath + "/Resources/LaunchScreen.storyboard", templatePath: "LaunchScreen.storyboard")
        }
    }
}

extension String {
    static var appBasePath: Self {
        return "Projects/App/\(appName)"
    }
}
