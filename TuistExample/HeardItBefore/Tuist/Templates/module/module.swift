import Foundation

import ProjectDescription

let moduleName: Template.Attribute = .required("name")
let modulePlatform: Template.Attribute = .optional("platform", default: "ios")

let template = Template(
    description: "New Module Template",
    attributes: [
        moduleName,
        modulePlatform
    ],
    items: ModuleTemplate.allCases.map { $0.item }
)

enum ModuleTemplate: CaseIterable {
    case project
    case baseFile
    // 테스트 프로젝트
    
    var item: Template.Item {
        switch self {
        case .project:
            return .file(path: .moduleBasePath + "/Project.swift", templatePath: "Project.stencil")
        case .baseFile:
            return .file(path: .moduleBasePath + "/Sources/BaseObject.swift", templatePath: "BaseObject.stencil")
        }
    }
}

extension String {
    static var moduleBasePath: Self {
        return "Projects/Feature/\(moduleName)"
    }
}
