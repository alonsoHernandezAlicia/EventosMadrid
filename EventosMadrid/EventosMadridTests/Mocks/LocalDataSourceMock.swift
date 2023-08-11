//
//  LocalDataSourceMock.swift
//  EventosMadridTests
//
//  Created by Alonso Hernández Alicia on 10/8/23.
//

import Foundation
@testable import EventosMadrid

class LocalDataSourceMock: LocalDataSourceProtocol {
    
    private let mockedEvents: [Event]
    private var persistedEvent: Event?
    
    init(mockedEvents: [Event]) {
        self.mockedEvents = mockedEvents
    }
    
    func getFavoriteEvents() -> [Event] {
        mockedEvents
    }
    
    func updateFavoriteEvent(_ favoriteEvent: Event) {
        self.persistedEvent = favoriteEvent
    }
}
