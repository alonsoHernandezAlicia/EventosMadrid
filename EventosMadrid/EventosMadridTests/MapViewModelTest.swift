//
//  MapViewModelTest.swift
//  EventosMadridTests
//
//  Created by Alonso Hernández Alicia on 10/8/23.
//

import XCTest
@testable import EventosMadrid

final class MapViewModelTest: XCTestCase {
    func testGivenAMapViewModel_whenInitIsCalled_thenAListOfEventsIsReturned() async {
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
                          link: URL(string: "URL"))
        let repository = EventsRepositoryMock(mockedEvents: [event])
        let sut: MapViewModel
        
        // When
        sut = MapViewModel(repository: repository)
        
        // Then
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(block: { _, _ in
            sut.events.first == event
        }), object: nil)
        
        await fulfillment(of: [expectation], timeout: 3)
    }
}
