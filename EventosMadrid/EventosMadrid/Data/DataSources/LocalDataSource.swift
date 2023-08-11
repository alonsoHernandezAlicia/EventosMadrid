//
//  LocalDataSource.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 9/8/23.
//

import Foundation

final class LocalDataSource: LocalDataSourceProtocol {
    private let favoriteEventsKey = "favoriteEvents"
    
    func getFavoriteEvents() -> [Event] {
        do {
            guard let data = UserDefaults.standard.data(forKey: favoriteEventsKey) else { return [] }
            let decodedData = try JSONDecoder().decode([Event].self, from: data)
            return decodedData
        } catch {
            return []
        }
    }
    
    func updateFavoriteEvent(_ favoriteEvent: Event) {
        var updatedFavoriteEvents = getFavoriteEvents()
        
        if let index = updatedFavoriteEvents.firstIndex(of: favoriteEvent) {
            updatedFavoriteEvents.remove(at: index)
        } else {
            updatedFavoriteEvents.append(favoriteEvent)
        }
        
        updateFavoriteEvents(updatedFavoriteEvents)
    }
    
    private func updateFavoriteEvents(_ favoriteEvents: [Event]) {
        guard let encodeData = try? JSONEncoder().encode(favoriteEvents) else { return }
        UserDefaults.standard.set(encodeData, forKey: favoriteEventsKey)
    }
}
