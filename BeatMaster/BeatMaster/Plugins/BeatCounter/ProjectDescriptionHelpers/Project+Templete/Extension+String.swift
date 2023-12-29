//
//  Extension+String.swift
//  MyPlugin
//
//  Created by 서원지 on 12/29/23.
//

import Foundation
import ProjectDescription

extension String {
  public static func appVersion() -> String {
      let version: String = "1.0.0"
      return version
  }
    
    public static func mainBundleID() -> String {
        return Project.Environment.bundlePrefix
    }
    
  public static func appBuildVersion() -> String {
      let buildVersion: String = "10"
      return buildVersion
  }
    
    
    public static func appBundleID(name: String) -> String {
        return Project.Environment.bundlePrefix+name
    }
    
}
