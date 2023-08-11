//
//  EventsRepository.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation

final class EventsRepository: RepositoryProtocol {

    private let remoteDataSource: RemoteDataSourceProtocol
    private let localDataSource: LocalDataSourceProtocol
    
    init(remoteDataSource: RemoteDataSourceProtocol, localDataSource: LocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
       
    func getEvents() async throws -> [Event]? {
        let events = try? await remoteDataSource.getEvents()
        
        let favoriteEvents = localDataSource.getFavoriteEvents()
        
        return events?.map {
            var event = $0
            event.favorite = favoriteEvents.contains(where: {
                event.id == $0.id
            })
            return event
        }
    }
    
    func getFavoriteEvents() -> [Event] {
        localDataSource.getFavoriteEvents()
    }
    
    func updateFavoriteEvent(_ favoriteEvent: Event) {
        localDataSource.updateFavoriteEvent(favoriteEvent)
    }
}
