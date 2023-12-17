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
        
        let appDevTarget = Target(
            name: "\(name)-Dev",
            platform: .iOS,
            product: product,
            bundleId: "\(bundleId)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: [],
            dependencies: dependencies
            
        )
        
        let appTestTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["\(name)Tests/Sources/**"],
            dependencies: [.target(name: name)]
        )
        
        let targets = [appTarget, appDevTarget, appTestTarget]
        
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


extension Scheme {
    public static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
    
}


extension String {
  public static func appVersion() -> String {
      let version: String = "1.0.0"
      return version
  }
    
    public static func watchAppVersion() -> String {
        let version: String = "1.0.0"
        return version
    }

  public static func appBuildVersion() -> String {
      let buildVersion: String = "10"
      return buildVersion
  }
    
    public static func mainBundleID() -> String {
        let bundleID = "com.BeatCounter"
        return bundleID
    }
    
    public static func appBundleID(name: String) -> String {
        let bundleID = "com.BeatCounter\(name)"
        return bundleID+name
    }
    
}
