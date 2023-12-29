//
//  Extension+Script.swift
//  MyPlugin
//
//  Created by 서원지 on 12/29/23.
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
