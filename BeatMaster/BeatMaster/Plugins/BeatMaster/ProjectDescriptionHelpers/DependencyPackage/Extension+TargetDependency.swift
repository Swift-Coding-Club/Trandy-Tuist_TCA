//
//  Extension+TargetDependency.swift
//  MyPlugin
//
//  Created by 서원지 on 1/6/24.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let Moya = TargetDependency.external(name: "Moya", condition: .none)
    static let CombineMoya = TargetDependency.external(name: "CombineMoya", condition: .none)
    static let ComposableArchitecture = TargetDependency.external(name: "ComposableArchitecture", condition: .none)
}
