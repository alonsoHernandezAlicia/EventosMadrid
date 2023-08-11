//
//  EventsRepositoryMock.swift
//  EventosMadridTests
//
//  Created by Alonso Hernández Alicia on 10/8/23.
//

import Foundation
@testable import EventosMadrid

class EventsRepositoryMock: RepositoryProtocol {
    private let mockedEvents: [Event]
    
    init(mockedEvents: [Event]) {
        self.mockedEvents = mockedEvents
    }
    
    func getEvents() async throws -> [Event]? {
        mockedEvents
    }
    
    func getFavoriteEvents() -> [Event] {
        []
    }
    
    func updateFavoriteEvent(_ favoriteEvent: Event) {
    }
}
