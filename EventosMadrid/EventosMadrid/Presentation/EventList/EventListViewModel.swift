//
//  EventListViewModel.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation

final class EventListViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var searchText: String = ""
    @Published var selection = 0
    
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
        
        Task {
            guard let eventsFromApi = try? await repository.getEvents() else {
                self.events = []
                print("Unable to get events from api")
                return
            }
            DispatchQueue.main.async {
                self.events = eventsFromApi
            }
        }
    }
    
    var filteredEvents: [Event] {
        let events: [Event]
        switch selection {
        case 1:
            events = self.events.filter { event in
                event.price.isEmpty
            }
        case 2:
            events = self.events.filter { event in
                event.favorite == true
            }
        default:
            events = self.events
        }

        guard !searchText.isEmpty else { return events }
        
        return events.filter { event in
            event.title.lowercased().contains(searchText.lowercased()) ||
             event.description.lowercased().contains(searchText.lowercased())
        }
    }
        
    func saveFavorite(_ event: Event) {
        guard let eventIndex = events.firstIndex(of: event) else { return }
        let isFavorite = events[eventIndex].favorite ?? false
        
        // Updates in-memory events array
        events[eventIndex].favorite = !isFavorite
        
        // Updates persisted favorite events
        repository.updateFavoriteEvent(event)
    }
}
