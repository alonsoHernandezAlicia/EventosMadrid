//
//  MapViewModel.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let event: Event
    let coordinate: CLLocationCoordinate2D
}

final class MapViewModel: ObservableObject {
    
    private let repository: RepositoryProtocol
    var events: [Event] = []
    var locations: [Location] = []
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
        Task {
            guard let eventsFromApi = try? await repository.getEvents() else {
                print("Unable to get events from api")
                return
            }

            DispatchQueue.main.async {
                self.events = eventsFromApi
                self.locations = eventsFromApi.map { event in
                    Location(event: event,
                             coordinate: CLLocationCoordinate2D(
                                latitude: event.location?.latitude ?? 0,
                                longitude: event.location?.longitude ?? 0))
                }
            }
        }
    }    
}
