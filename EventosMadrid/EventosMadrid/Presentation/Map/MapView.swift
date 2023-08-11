//
//  MapView.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var mapViewModel: MapViewModel
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
    }
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.48, longitude: -3.68), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        NavigationStack {
            Map(coordinateRegion: .constant(mapRegion), annotationItems: mapViewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        EventDetailView(detailViewModel: EventDetailConfigurator.buildViewModel(event: location.event))
                    } label: {
                        Image(systemName: "mappin")
                            .resizable()
                            .foregroundColor(Color("PrimaryColor"))
                            .scaledToFit()
                            .frame(height: 30)
                    }
                }
            }
            .navigationTitle("Map")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapViewModel: MapConfigurator.buildViewModel())
    }
}
