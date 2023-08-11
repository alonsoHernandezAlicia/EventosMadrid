//
//  MapConfigurator.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation

class MapConfigurator {
    static func buildViewModel() -> MapViewModel {
        let remoteDataSource = RemoteDataSource()
        let networkFetchingRepository = EventsRepository(remoteDataSource: remoteDataSource, localDataSource: LocalDataSource())
        return MapViewModel(repository: networkFetchingRepository)
    }
}
