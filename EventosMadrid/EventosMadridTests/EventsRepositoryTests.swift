//
//  EventsRepositoryTests.swift
//  EventosMadridTests
//
//  Created by Alonso Hernández Alicia on 10/8/23.
//

import XCTest
@testable import EventosMadrid

final class EventsRepositoryTests: XCTestCase {
    
    func testGivenEventsRepository_whenGetEventsIsCalledAndThereAreNoFavoriteEventsPersisted_thenAListOfEventsIsReturnedAndNoneOfThemAreFavorite() async {
        // Given
        let eventMock = Event(id: "1111",
                              title: "",
                              description: "",
                              price: "",
                              location: Localization(latitude: 0,
                                                     longitude: 0),
                              dtstart: "",
                              time: "",
                              eventLocation: "",
                              link: URL(string: "URL")
        )
        let remoteDataSourceMock = RemoteDataSourceMock(mockedEvents: [eventMock])
        let localDataSourceMock = LocalDataSourceMock(mockedEvents: [])
        let sut = EventsRepository(remoteDataSource: remoteDataSourceMock, localDataSource: localDataSourceMock)
        
        // When
        let events = try? await sut.getEvents()
        
        // Then
        XCTAssertNotNil(events, "A list of events should be returned")
        XCTAssertNotNil(events?.first)
        XCTAssertEqual(events?.first?.id, "1111")
        XCTAssertTrue(events?.first?.favorite == false)
    }
}
