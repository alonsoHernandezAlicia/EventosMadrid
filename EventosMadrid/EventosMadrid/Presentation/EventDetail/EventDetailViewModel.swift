//
//  EventDetailViewModel.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 8/8/23.
//

import Foundation

final class EventDetailViewModel: ObservableObject {
    var event: Event
    
    init(event: Event) {
        self.event = event
    }
}
