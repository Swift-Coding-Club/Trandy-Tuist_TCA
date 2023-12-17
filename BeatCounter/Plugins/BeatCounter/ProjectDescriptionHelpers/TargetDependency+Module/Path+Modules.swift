//
//  Path+Modules.swift
//  MyPlugin
//
//  Created by 서원지 on 12/17/23.
//

import Foundation
import ProjectDescription

// MARK: ProjectDescription.Path + App
public extension ProjectDescription.Path {
    static var app: Self {
        return .relativeToRoot("Projects/\(ModulePath.App.name)")
    }
}


// MARK: ProjectDescription.Path + Feature
public extension ProjectDescription.Path {
    static var Feature: Self {
        return .relativeToRoot("Projects/\(ModulePath.Features.name)")
    }
    
    static func Feature(implementation module: ModulePath.Features) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Features.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Core
public extension ProjectDescription.Path {
    static var Core: Self {
        return .relativeToRoot("Projects/\(ModulePath.Cores.name)")
    }
    
    static func Core(implementation module: ModulePath.Cores) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Cores.name)/\(module.rawValue)")
    }
}


// MARK: ProjectDescription.Path + DesignSystem

public extension ProjectDescription.Path {
    static var Shared: Self {
        return .relativeToRoot("Projects/\(ModulePath.Shareds.name)")
    }
    
    static func Shared(implementation module: ModulePath.Shareds) -> Self {
        return .relativeToRoot("Projects/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Domain

public extension ProjectDescription.Path {
    static var Networking: Self {
        return .relativeToRoot("Projects/\(ModulePath.Networkings.name)/\(ModulePath.Networkings.name)")
    }
    
    static func Networking(implementation module: ModulePath.Networkings) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Networkings.name)/\(ModulePath.Networkings.name)/\(module.rawValue)")
    }
}


