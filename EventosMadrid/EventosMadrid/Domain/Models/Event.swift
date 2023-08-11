//
//  Event.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation

struct EventGraph: Codable {
    let events: [Event]
    
    enum CodingKeys: String, CodingKey {
        case events = "@graph"
    }
}

struct Localization: Codable, Hashable {
    let latitude: Double
    let longitude: Double
}

struct Event: Codable, Identifiable, Hashable, Comparable, Equatable {
    let id: String
    let title: String
    let description: String
    let price: String
    let location: Localization?
    let dtstart: String?
    let time: String?
    let eventLocation: String?
    let link: URL?
    
    var favorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case price
        case location
        case dtstart
        case time
        case eventLocation = "event-location"
        case link
        case favorite
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.title < rhs.title
    }
}


