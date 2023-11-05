//
//  ContactDetailFeature.swift
//  TCA_Naviagation
//
//  Created by 서원지 on 11/5/23.
//

import Foundation
import ComposableArchitecture

struct ContactDetailFeature: Reducer {
    struct State: Equatable {
        let contact: Contact
    }
    
    enum Action: Equatable {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}
