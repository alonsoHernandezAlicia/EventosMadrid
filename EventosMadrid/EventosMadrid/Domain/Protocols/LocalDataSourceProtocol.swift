//
//  LocalDataSourceProtocol.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 9/8/23.
//

import Foundation

protocol LocalDataSourceProtocol {
    func getFavoriteEvents() -> [Event]
    func updateFavoriteEvent(_ favoriteEvent: Event)
}
