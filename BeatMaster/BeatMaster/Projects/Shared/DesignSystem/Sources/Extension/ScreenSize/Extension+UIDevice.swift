//
//  Extension+UIDevice.swift
//  DesignSystem
//
//  Created by 서원지 on 12/29/23.
//  Copyright © 2023 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI

public extension UIDevice {
  public static var hasNotch: Bool {
        let bottom = UIApplication.shared.windows[0].safeAreaInsets.bottom
        return bottom > 0
    }
}
