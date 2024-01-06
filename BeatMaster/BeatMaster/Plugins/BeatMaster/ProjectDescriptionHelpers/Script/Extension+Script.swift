//
//  Extension+Script.swift
//  MyPlugin
//
//  Created by 서원지 on 1/6/24.
//

import Foundation
import ProjectDescription

public extension TargetScript {
    static let SwiftLintString = TargetScript.pre(
        script: swiftLintScript,
        name: "SwiftLintString",
        basedOnDependencyAnalysis: false
    )
}
