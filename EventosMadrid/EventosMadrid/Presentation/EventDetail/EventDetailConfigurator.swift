//
//  EventDetailConfigurator.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 8/8/23.
//

import Foundation

class EventDetailConfigurator {
    static func buildViewModel(event: Event) -> EventDetailViewModel {
        let remoteDataSource = RemoteDataSource()
        let networkFetchingRepository = EventsRepository(remoteDataSource: remoteDataSource, localDataSource: LocalDataSource())
        return EventDetailViewModel(event: event)
    }
}


