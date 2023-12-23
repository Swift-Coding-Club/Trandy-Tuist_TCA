//
//  Dependencies.swift
//  Manifests
//
//  Created by 서원지 on 12/17/23.
//

import Foundation
import ProjectDescription

let swiftpackage = SwiftPackageManagerDependencies([
    .remote(url: "http://github.com/pointfreeco/swift-composable-architecture", requirement: .exact("1.5.0")),
])

let dependencie = Dependencies(
    swiftPackageManager: swiftpackage,
    platforms: [.iOS]
)
