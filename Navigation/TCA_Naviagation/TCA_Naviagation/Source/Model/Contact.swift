//
//  Contact.swift
//  TCA_Naviagation
//
//  Created by 서원지 on 11/5/23.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}
