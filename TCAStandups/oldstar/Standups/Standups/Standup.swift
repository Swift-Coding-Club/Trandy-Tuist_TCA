//
//  Standup.swift
//  Standups
//
//  Created by Gordon Choi on 11/5/23.
//

import Foundation

struct Standup: Equatable, Identifiable, Codable {
    let id: UUID
    var attendees: [Attendee] = []
    var duration = Duration.seconds(60 * 5)
    var meetings: [Meeting] = []
    var theme: Theme = .bubblegum
    var title = ""
    
    var durationPerAttendee: Duration {
        duration / attendees.count
    }
}

struct Attendee: Equatable, Identifiable, Codable {
    let id: UUID
    var name = ""
}

struct Meeting: Equatable, Identifiable, Codable {
    let id: UUID
    let date: Date
    var transcript: String
}

extension Standup {
    static let mock = Self(
        id: Standup.ID(),
        attendees: [
            Attendee(id: Attendee.ID(), name: "Blob"),
            Attendee(id: Attendee.ID(), name: "Blob Jr"),
            Attendee(id: Attendee.ID(), name: "Blob Sr"),
            Attendee(id: Attendee.ID(), name: "Blob Esq"),
            Attendee(id: Attendee.ID(), name: "Blob III"),
            Attendee(id: Attendee.ID(), name: "Blob I"),
        ],
        duration: .seconds(60),
        meetings: [
            Meeting(
                id: Meeting.ID(),
                date: Date().addingTimeInterval(-60 * 60 * 24 * 7),
                transcript: """
          Lorem ipsum dolor sit amet, consectetur \
          adipiscing elit, sed do eiusmod tempor \
          incididunt ut labore et dolore magna aliqua. Ut \
          enim ad minim veniam, quis nostrud exercitation \
          ullamco laboris nisi ut aliquip ex ea commodo \
          consequat. Duis aute irure dolor in \
          reprehenderit in voluptate velit esse cillum \
          dolore eu fugiat nulla pariatur. Excepteur sint \
          occaecat cupidatat non proident, sunt in culpa \
          qui officia deserunt mollit anim id est laborum.
          """
            )
        ],
        theme: .orange,
        title: "Design"
    )
}
