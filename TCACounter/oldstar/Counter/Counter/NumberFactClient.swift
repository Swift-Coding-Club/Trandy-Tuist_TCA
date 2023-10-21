//
//  NumberFactClient.swift
//  Counter
//
//  Created by Gordon Choi on 10/22/23.
//

import Foundation

import ComposableArchitecture

struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static let liveValue = Self(fetch: { number in
        let (data, _) = try await URLSession.shared
            .data(from: URL(string: "http://numbersapi.com/\(number)")!)
        
        return String(decoding: data, as: UTF8.self)
    })
}

// @Dependency와 관련된 부분
extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
