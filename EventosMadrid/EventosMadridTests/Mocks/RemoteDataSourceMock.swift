//
//  RemoteDataSourceMock.swift
//  EventosMadridTests
//
//  Created by Alonso Hernández Alicia on 10/8/23.
//

import Foundation
@testable import EventosMadrid

class RemoteDataSourceMock: RemoteDataSourceProtocol {
    
    private let mockedEvents: [Event]
    
    init(mockedEvents: [Event]) {
        self.mockedEvents = mockedEvents
    }
    
    func getEvents() async throws -> [Event]? {
        return mockedEvents
    }
}

