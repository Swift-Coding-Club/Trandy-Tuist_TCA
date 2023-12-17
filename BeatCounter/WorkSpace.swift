//
//  Workspace.swift
//  Manifests
//
//  Created by 서원지 on 12/17/23.
//

import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let workspace = Workspace(
name: Project.Environment.appName,
projects: [
    "Projects/**"
])

