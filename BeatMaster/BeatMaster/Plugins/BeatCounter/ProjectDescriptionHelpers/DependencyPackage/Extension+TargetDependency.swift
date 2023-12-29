//
//  Extension+TargetDependency.swift
//  MyPlugin
//
//  Created by 서원지 on 12/17/23.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let Moya = TargetDependency.external(name: "Moya")
    static let CombineMoya = TargetDependency.external(name: "CombineMoya")
}
