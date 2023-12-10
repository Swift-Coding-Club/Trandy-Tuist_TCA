//
//  Project+Template.swift
//  MyPlugin
//
//  Created by Gordon Choi on 12/10/23.
//

import ProjectDescription

public extension Project {
    public enum Environment {
        public static let appName = "BeatCounter"
        public static let organizationName = "" // and so on
        public static let deploymentTarget = DeploymentTarget.iOS(targetVersion: "17.0", devices: [.iphone, .ipad])
        public static let bundlePrefix = "com." // and so on
        public static let appVersion = "1.0.0"
        public static let mainBundleId = "com.BeatCounter"
    }
}

public extension Project {
    static func makeAppModule(
        name: String = Environment.appName,
        bundleId: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = Environment.organizationName,
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget = Environment.deploymentTarget,
        settings: Settings,
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = .sources,
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        entitlements: Entitlements? = nil,
        schemes: [Scheme] = []
    ) -> Project {
        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: bundleId,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: [],
            dependencies: dependencies
        )
        
        let targets = [appTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}

public extension SourceFilesList {
    static let sources: SourceFilesList = "Sources/**"
}
