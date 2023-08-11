//
//  RootView.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import SwiftUI

struct RootView: View {
    
    var rootViewModel: RootViewModel
    
    var body: some View {
        switch (rootViewModel.status) {
            
        case Status.none:
            HomeView()
            
        case Status.loading:
            ProgressView()
            
        case Status.error(error: let errorString):
            Text("Error \(errorString)")
            
        case Status.loaded:
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                EventListView(eventListViewModel: EventListViewModel(repository: rootViewModel.repository))
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Event List")
                    }
                
                MapView(mapViewModel: MapConfigurator.buildViewModel())
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(rootViewModel: RootConfigurator.buildViewModel())
    }
}
