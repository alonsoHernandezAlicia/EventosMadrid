//
//  RootConfigurator.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import SwiftUI

class RootConfigurator {
    static func buildViewModel() -> RootViewModel {
        let remoteDataSource = RemoteDataSource()
        let networkFetchingRepository = EventsRepository(remoteDataSource: remoteDataSource, localDataSource: LocalDataSource())
        return RootViewModel(repository: networkFetchingRepository)
    }
}
