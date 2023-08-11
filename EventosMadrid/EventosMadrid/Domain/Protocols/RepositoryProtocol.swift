//
//  RepositoryProtocol.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation

protocol RepositoryProtocol {
    func getEvents() async throws -> [Event]?
    func getFavoriteEvents() -> [Event]
    func updateFavoriteEvent(_ favoriteEvent: Event)
}

