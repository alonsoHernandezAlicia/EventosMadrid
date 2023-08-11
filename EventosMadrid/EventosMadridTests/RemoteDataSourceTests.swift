//
//  RemoteDataSourceTests.swift
//  EventosMadridTests
//
//  Created by Alonso Hernández Alicia on 10/8/23.
//

import XCTest
@testable import EventosMadrid

final class RemoteDataSourceTests: XCTestCase {
    
    var sut: RemoteDataSource?
    
    func testGivenRemoteDataSource_whenGetEventsIsCalled_thenAListOfEventsIsReturned() async {
        
        // Given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let mockURLSession = URLSession.init(configuration: configuration)
        
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            
            let eventGraph = EventGraph(events: [
                Event(id: "1111",
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
            ])
            let data = try JSONEncoder().encode(eventGraph)
            return (response, data)
        }
        
        sut = RemoteDataSource(session: mockURLSession)
        
        // When
        let events = try? await sut?.getEvents()
        
        // Then
        XCTAssertNotNil(events, "Events must contain an Event")
        XCTAssertNotNil(events?.first)
        XCTAssertEqual(events?.first?.id, "1111")
    }
    
    
    func testGivenRemoteDataSource_whenGetEventsIsCalledAndAPIFails_thenAnExceptionMustBeThrown() async {
        
        // Given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let mockURLSession = URLSession.init(configuration: configuration)
        
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        sut = RemoteDataSource(session: mockURLSession)
        
        // When - Then
        let expectation = expectation(description: "expect call to throw an exception")
        
        do {
            // This call is expected to fail
            _ = try await sut?.getEvents()
        } catch {
            // Expectation is fulfilled when call fails
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1)
    }
}
