//
//  EventListConfigurator.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 8/8/23.
//

import Foundation

class EventListConfigurator {
    static func buildViewModel() -> EventListViewModel {
        let remoteDataSource = RemoteDataSource()
        let networkFetchingRepository = EventsRepository(remoteDataSource: remoteDataSource, localDataSource: LocalDataSource())
        return EventListViewModel(repository: networkFetchingRepository)
    }
}
