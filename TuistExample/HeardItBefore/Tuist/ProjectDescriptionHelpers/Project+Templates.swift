// Project+Templates.swift

import Foundation

import ProjectDescription

public extension Project {
    static func makeAppModule(
        name: String,
        bundleId: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "Gordon Choi",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "16.0", devices: [.iphone]),
        settings: Settings,
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        entitlements: Path? = nil,
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
    
    static func makeLibraryModule(
        name: String,
        bundleId: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String,
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "16.0", devices: [.iphone]),
        settings: Settings,
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        entitlements: Path? = nil,
        schemes: [Scheme] = []
    ) -> Project {
        let featureTarget = Target(
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
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["\(name)Tests/Sources/**"],
            dependencies: [.target(name: name)]
        )
        
        let targets = [featureTarget, testTarget]
        
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

public extension String {
    static func appVersion() -> String {
        let version: String = "2.0.0"
        return version
    }
    
    static func appBuildVersion() -> String {
        let buildVersion: String = "1"
        return buildVersion
    }
    
    static func mainBundleID() -> String {
        let bundleID = "com.gordonchoi.WhereIsMyMusic"
        return bundleID
    }
    
    static func appBundleID(name: String) -> String {
        let bundleID = "com.gordonchoi.WhereIsMyMusic."
        return bundleID+name
    }
}
