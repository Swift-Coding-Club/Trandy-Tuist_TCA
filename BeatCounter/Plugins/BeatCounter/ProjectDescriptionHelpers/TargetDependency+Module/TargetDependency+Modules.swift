//
//  TargetDependency+Modules.swift
//  MyPlugin
//
//  Created by 서원지 on 12/17/23.
//

import Foundation
import ProjectDescription

// MARK: TargetDependency + App

public extension TargetDependency {
    static var app: Self {
        return .project(target: ModulePath.App.name, path: .app)
    }
    
    static func app(implements module: ModulePath.App) -> Self {
        return .target(name: ModulePath.App.name + module.rawValue)
    }
}

// MARK: TargetDependency + Feature
public extension TargetDependency {
    static func Feature(implements module: ModulePath.Features) -> Self {
        return .project(target: module.rawValue, path: .Feature(implementation: module))
    }
}

// MARK: TargetDependency + Design
public extension TargetDependency {
    static func Shared(implements module: ModulePath.Shareds) -> Self {
        return .project(target: module.rawValue, path: .Shared(implementation: module))
    }
}

// MARK: TargetDependency + Core
public extension TargetDependency {
    static func Core(implements module: ModulePath.Cores) -> Self {
        return .project(target: module.rawValue, path: .Core(implementation: module))
    }
}


// MARK: TargetDependency + Domain

public extension TargetDependency {
    static func Networking(implements module: ModulePath.Networkings) -> Self {
        return .project(target: module.rawValue, path: .Networking(implementation: module))
    }
}

