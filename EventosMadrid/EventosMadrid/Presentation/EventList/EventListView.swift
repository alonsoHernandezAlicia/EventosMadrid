//
//  EventList.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import SwiftUI

struct EventListView: View {
    
    @ObservedObject var eventListViewModel: EventListViewModel
    @State private var favoriteColor = 0
    
    
    init(eventListViewModel: EventListViewModel) {
        self.eventListViewModel = eventListViewModel
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List {
                    Picker("",selection: $eventListViewModel.selection) {
                        Text("All").tag(0)
                        Text("Free").tag(1)
                        Text("Favorites").tag(2)
                    }
                    .pickerStyle(.segmented)

                    ForEach(eventListViewModel.filteredEvents) { event in
                        NavigationLink {
                            EventDetailView(detailViewModel: EventDetailConfigurator.buildViewModel(event: event))
                        } label: {
                            EventCellView(event: event) {
                                eventListViewModel.saveFavorite(event)
                            }
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .listStyle(GroupedListStyle())
                .scrollContentBackground(.hidden) // Esconder el background
                .navigationTitle("Events")
            }
            .searchable(text: $eventListViewModel.searchText)
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(eventListViewModel: EventListViewModel(repository: EventsRepository(remoteDataSource: RemoteDataSource(), localDataSource: LocalDataSource())))
    }
}
