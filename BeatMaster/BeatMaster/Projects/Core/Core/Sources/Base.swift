//
//  base.swift
//  ChaeviUS
//
//  Created by 서원지 on 2023/12/27
//  Copyright © 2023 Team.hae.jo, All rights reserved.
//

import SwiftUI

public struct BaseView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

