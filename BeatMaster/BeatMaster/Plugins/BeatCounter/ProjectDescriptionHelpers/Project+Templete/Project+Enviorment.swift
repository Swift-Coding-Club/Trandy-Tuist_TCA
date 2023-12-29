//
//  Project+Enviorment.swift
//  MyPlugin
//
//  Created by 서원지 on 12/29/23.
//

import Foundation
import ProjectDescription

public extension Project {
    public enum Environment {
        public static let appName = "BeatMaster"
        public static let appDevName = "BeatMaster-Dev"
        public static let organizationName = "Wonji suh"
        public static let organizationTeamId = "N94CS4N6VR"
        public static let deploymentTarget = DeploymentTarget.iOS(targetVersion: "17.0", devices: [.iphone, .ipad])
        public static let bundlePrefix = "com.Haejoo.BeatMaster"
        public static let appVersion = "1.0.0"
        public static let mainBundleId = "com.BeatCounter"
    }
}
