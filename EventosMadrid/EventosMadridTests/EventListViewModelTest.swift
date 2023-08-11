//
//  EventListViewModelTest.swift
//  EventosMadridTests
//
//  Created by Alonso Hernández Alicia on 10/8/23.
//

import XCTest
@testable import EventosMadrid

final class EventListViewModelTest: XCTestCase {
    func testGivenAnEventListViewModel_whenInitIsCalled_thenAListOfEventsIsReturned() async {
        
        // Given
        let mockedEvent = Event(id: "1111",
                                title: "",
                                description: "",
                                price: "",
                                location: Localization(latitude: 0,
                                                       longitude: 0),
                                dtstart: "",
                                time: "",
                                eventLocation: "",
                                link: URL(string: "URL"),
                                favorite: false)
        let repository = EventsRepositoryMock(mockedEvents: [mockedEvent])
        let sut: EventListViewModel
        
        // When
        sut = EventListViewModel(repository: repository)
        
        // Then
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(block: { _, _ in
            sut.events.first == mockedEvent
        }), object: nil)
        
        await fulfillment(of: [expectation], timeout: 3)
    }
    
    func testGivenAnEventListViewModel_whenFilteredEventsIsCalledAndNoFiltersAreApplied_thenTheFullListOfEventsIsReturned() async {
        
        // Given
        let mockedEvent = Event(id: "1111",
                                title: "",
                                description: "",
                                price: "",
                                location: Localization(latitude: 0,
                                                       longitude: 0),
                                dtstart: "",
                                time: "",
                                eventLocation: "",
                                link: URL(string: "URL"),
                                favorite: false)
        
        let repository = EventsRepositoryMock(mockedEvents: [mockedEvent])
        let sut = EventListViewModel(repository: repository)
        sut.searchText = ""
        sut.selection = 0
        
        // When
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(block: { _, _ in
            !sut.events.isEmpty
        }), object: nil)
        
        // This await is needed because we need to wait for events to be loaded to test filteredEvents computed property.
        await fulfillment(of: [expectation], timeout: 3)
        
        let filteredEvents = sut.filteredEvents
        
        // Then
        XCTAssertEqual(filteredEvents.count, 1)
        XCTAssertTrue(filteredEvents.first == mockedEvent)
    }
    
    func testGivenAnEventListViewModel_whenFilteredEventsIsCalledAndFreeFilterIsApplied_thenOnlyFreeEventsListIsReturned() async {
        // Given
        let mockedEvent = Event(id: "1111",
                                title: "",
                                description: "",
                                price: "56",
                                location: Localization(latitude: 0,
                                                       longitude: 0),
                                dtstart: "",
                                time: "",
                                eventLocation: "",
                                link: URL(string: "URL"),
                                favorite: false)
        
        let mockedFreeEvent = Event(id: "2222",
                                    title: "",
                                    description: "",
                                    price: "",
                                    location: Localization(latitude: 0,
                                                           longitude: 0),
                                    dtstart: "",
                                    time: "",
                                    eventLocation: "",
                                    link: URL(string: "URL"),
                                    favorite: false)
        
        let repository = EventsRepositoryMock(mockedEvents: [mockedEvent, mockedFreeEvent])
        let sut = EventListViewModel(repository: repository)
        sut.searchText = ""
        sut.selection = 1
        
        // When
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(block: { _, _ in
            !sut.events.isEmpty
        }), object: nil)
        await fulfillment(of: [expectation], timeout: 3)
        
        let filteredEvents = sut.filteredEvents
        
        // Then
        XCTAssertEqual(filteredEvents.count, 1)
        XCTAssertTrue(filteredEvents.first == mockedFreeEvent)
    }
    
    func testGivenAnEventListViewModel_whenFilteredEventsIsCalledAndFavoritesFilterIsApplied_thenOnlyFavoriteEventsListIsReturned() async {
        // Given
        let mockedEvent = Event(id: "1111",
                                title: "",
                                description: "",
                                price: "",
                                location: Localization(latitude: 0,
                                                       longitude: 0),
                                dtstart: "",
                                time: "",
                                eventLocation: "",
                                link: URL(string: "URL"),
                                favorite: false)
        
        let mockedFavoriteEvent = Event(id: "2222",
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
        
        let repository = EventsRepositoryMock(mockedEvents: [mockedEvent, mockedFavoriteEvent])
        let sut = EventListViewModel(repository: repository)
        sut.searchText = ""
        sut.selection = 2
        
        // When
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(block: { _, _ in
            !sut.events.isEmpty
        }), object: nil)
        await fulfillment(of: [expectation], timeout: 3)
        
        let filteredEvents = sut.filteredEvents
        
        // Then
        XCTAssertEqual(filteredEvents.count, 1)
        XCTAssertTrue(filteredEvents.first == mockedFavoriteEvent)
    }
    
    func testGivenAnEventListViewModel_whenFilteredEventsIsCalledAndSearchFilterIsApplied_thenOnlyEventsThatMatchTheSearchAreReturned() async {
        // Given
        let mockedEvent = Event(id: "1111",
                                title: "",
                                description: "",
                                price: "",
                                location: Localization(latitude: 0,
                                                       longitude: 0),
                                dtstart: "",
                                time: "",
                                eventLocation: "",
                                link: URL(string: "URL"),
                                favorite: false)
        
        let mockedSearchedEvent = Event(id: "2222",
                                        title: "Event 2",
                                        description: "",
                                        price: "",
                                        location: Localization(latitude: 0,
                                                               longitude: 0),
                                        dtstart: "",
                                        time: "",
                                        eventLocation: "",
                                        link: URL(string: "URL"),
                                        favorite: true)
        
        let repository = EventsRepositoryMock(mockedEvents: [mockedEvent, mockedSearchedEvent])
        let sut = EventListViewModel(repository: repository)
        sut.searchText = "Event"
        sut.selection = 0
        
        // When
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(block: { _, _ in
            !sut.events.isEmpty
        }), object: nil)
        await fulfillment(of: [expectation], timeout: 3)
        
        let filteredEvents = sut.filteredEvents
        
        // Then
        XCTAssertEqual(filteredEvents.count, 1)
        XCTAssertTrue(filteredEvents.first == mockedSearchedEvent)
    }
    
    func testGivenAnEventListViewModel_whenSaveFavoriteIsCalled_thenTheInMemoryEventsArrayIsUpdatedAccordingly() async {
        
        // Given
        let mockedEvent = Event(id: "1111",
                                title: "",
                                description: "",
                                price: "",
                                location: Localization(latitude: 0,
                                                       longitude: 0),
                                dtstart: "",
                                time: "",
                                eventLocation: "",
                                link: URL(string: "URL"),
                                favorite: false)
        
        let repository = EventsRepositoryMock(mockedEvents: [mockedEvent])
        let sut = EventListViewModel(repository: repository)
        
        // When
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(block: { _, _ in
            !sut.events.isEmpty
        }), object: nil)
        await fulfillment(of: [expectation], timeout: 3)
        
        sut.saveFavorite(mockedEvent)
        
        // Then
        XCTAssertTrue(sut.events.first?.favorite == true)
    }
}
