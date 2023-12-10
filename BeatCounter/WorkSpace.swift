//
//  WorkSpace.swift
//  ProjectDescriptionHelpers
//
//  Created by 염성훈 on 12/10/23.
//

import Foundation
import ProjectDescription
import MyPlugin


let workSpace = Workspace(
    name: Project.Environment.appName,
    projects: ["Projects/**"]
)
