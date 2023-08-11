//
//  LocalDataSourceTests.swift
//  EventosMadridTests
//
//  Created by Alonso Hernández Alicia on 10/8/23.
//

import XCTest
@testable import EventosMadrid

final class LocalDataSourceTests: XCTestCase {
    
    let favoriteEventsKey = "favoriteEvents"
    
    override func setUp() {
        UserDefaults.standard.removeObject(forKey: favoriteEventsKey)
    }
    
    func testGivenLocalDataSource_whenGetFavoriteEventsIsCalled_thenAListOfEventsIsReturned() {
        // Given
        let eventsList: [Event] = [
            Event(id: "1111",
                  title: "",
                  description: "",
                  price: "",
                  location: Localization(latitude: 0,
                                         longitude: 0),
                  dtstart: "",
                  time: "",
                  eventLocation: "",
                  link: URL(string: "URL"),
                  favorite: true)
        ]
        
        let encodeData = try? JSONEncoder().encode(eventsList)
        UserDefaults.standard.set(encodeData, forKey: favoriteEventsKey)
        
        let sut = LocalDataSource()
        
        // When
        let events = sut.getFavoriteEvents()
        
        // Then
        XCTAssertEqual(events.count, 1)
        XCTAssertEqual(events.first?.id, "1111")
        XCTAssertEqual(events.first?.favorite, true)
    }
    
    func testGivenLocalDataSource_whenGetFavoriteEventsIsCalledAndFails_thenAnEmptyArrayMustBeReturned() {
        // Given
        let encodeData = try? JSONEncoder().encode("Event")
        UserDefaults.standard.set(encodeData, forKey: favoriteEventsKey)
        
        let sut = LocalDataSource()
        
        // When
        let events = sut.getFavoriteEvents()
        
        // Then
        XCTAssertTrue(events.isEmpty)
    }
    
    func testGivenLocalDataSource_whenGetFavoriteEventsIsCalledAndNoValuesAreStoredAssociatedToTheKey_thenAnEmptyArrayMustBeReturned() {
        // Given
        let sut = LocalDataSource()
        
        // When
        let events = sut.getFavoriteEvents()
        
        // Then
        XCTAssertTrue(events.isEmpty)
    }
    
    
    func testGivenLocalDataSource_whenUpdateFavoriteEventIsCalledAndTheEventWasntFavorite_thenTheEventMustBeStoredAsFavorite() {
        // Given
        let event = Event(id: "1111",
                          title: "",
                          description: "",
                          price: "",
                          location: Localization(latitude: 0,
                                                 longitude: 0),
                          dtstart: "",
                          time: "",
                          eventLocation: "",
                          link: URL(string: "URL"),
                          favorite: true)
        
        let sut = LocalDataSource()
        
        // When
        sut.updateFavoriteEvent(event)
        
        // Then
        guard let data = UserDefaults.standard.data(forKey: favoriteEventsKey) else {
            XCTFail("A value must be stored related to the key \(favoriteEventsKey)")
            return
        }
        
        guard let events = try? JSONDecoder().decode([Event].self, from: data) else {
            XCTFail("An array of events must be stored related to the key \(favoriteEventsKey)")
            return
        }

        XCTAssertEqual(events.first?.id, "1111")
        XCTAssertEqual(events.first?.favorite, true)
    }
    
    func testGivenLocalDataSource_whenUpdateFavoriteEventIsCalledAndTheEventWasAlreadyFavorite_thenTheEventMustBeRemovedAsFavorite() {
        // Given
        let event = Event(id: "1111",
                          title: "",
                          description: "",
                          price: "",
                          location: Localization(latitude: 0,
                                                 longitude: 0),
                          dtstart: "",
                          time: "",
                          eventLocation: "",
                          link: URL(string: "URL"),
                          favorite: true)
        let encodeData = try? JSONEncoder().encode([event])
        UserDefaults.standard.set(encodeData, forKey: favoriteEventsKey)

        let sut = LocalDataSource()
        
        // When
        sut.updateFavoriteEvent(event)
        
        // Then
        guard let data = UserDefaults.standard.data(forKey: favoriteEventsKey) else {
            XCTFail("A value must be stored related to the key \(favoriteEventsKey)")
            return
        }
        
        guard let events = try? JSONDecoder().decode([Event].self, from: data) else {
            XCTFail("An array of events must be stored related to the key \(favoriteEventsKey)")
            return
        }

        XCTAssertTrue(events.isEmpty)
    }
}
