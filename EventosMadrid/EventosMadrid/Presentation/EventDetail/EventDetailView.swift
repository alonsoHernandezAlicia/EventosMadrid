//
//  EventDetailView.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 8/8/23.
//

import SwiftUI

struct EventDetailView: View {
    
    var detailViewModel: EventDetailViewModel
    
    init( detailViewModel: EventDetailViewModel) {
        
        self.detailViewModel = detailViewModel
    }
    
    var body: some View {
        NavigationStack {
            Text(detailViewModel.event.title)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.init(top: 10, leading: 10, bottom: 30, trailing: 10))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("PrimaryColor"))
                .shadow(radius: 15)
                .accessibilityLabel(Text(detailViewModel.event.title))
            
            Text(detailViewModel.event.description).multilineTextAlignment(.center)
                .fontWeight(.light)
                .accessibilityLabel(Text(detailViewModel.event.description))
            
            VStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("Date:").fontWeight(.bold)
                        if(detailViewModel.event.dtstart != "" && detailViewModel.event.dtstart != nil) {
                            let date = Utils.parseEventDate(dateTime: detailViewModel.event.dtstart ?? "")
                            Text(date)
                                .accessibilityLabel(Text(date))
                        } else {
                            Text("Por determinar")
                                .accessibilityLabel(Text("Por determinar"))
                        }
                    }.foregroundColor(Color("PrimaryColor"))
                        .padding(.bottom, 2)
                    
                    HStack {
                        Image(systemName: "clock")
                        Text("Time:").fontWeight(.bold)
                        if(detailViewModel.event.time != "" && detailViewModel.event.time != nil) {
                            Text(detailViewModel.event.time ?? "")
                                .accessibilityLabel(Text(detailViewModel.event.time ?? ""))
                        } else {
                            Text("Por determinar")
                                .accessibilityLabel(Text("Por determinar"))
                        }
                    }.foregroundColor(Color("PrimaryColor"))
                        .padding(.bottom, 2)
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Address:").fontWeight(.bold)
                        if(detailViewModel.event.eventLocation != "" && detailViewModel.event.eventLocation != nil) {
                            Text(detailViewModel.event.eventLocation ?? "")
                                .accessibilityLabel(Text(detailViewModel.event.eventLocation ?? ""))
                        } else {
                            Text("Por determinar")
                                .accessibilityLabel(Text("Por determinar"))
                        }
                    }.foregroundColor(Color("PrimaryColor"))
                        .padding(.bottom, 2)
                    
                    
                    HStack {
                        Image(systemName: "eurosign.circle")
                        Text("Price:").fontWeight(.bold)
                        if (detailViewModel.event.price != "") {
                            Text(detailViewModel.event.price)
                                .accessibilityLabel(Text(detailViewModel.event.price))
                            
                        } else {
                            Text("Gratis")
                                .accessibilityLabel(Text("Gratis"))
                        }
                        
                    }.foregroundColor(Color("PrimaryColor"))
                        .padding(.bottom, 2)
                    
                }.padding()
                
                if(detailViewModel.event.eventLocation != "") {
                    Button {
                        if let url = detailViewModel.event.link {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Image(systemName: "link")
                        Text("More info")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
        }
        .scrollContentBackground(.hidden)
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(detailViewModel: EventDetailConfigurator.buildViewModel(event: Event(
            id: "2",
            title: "2001: Una odisea del espacio",
            description:"Hace millones de años, antes de la aparición del 'homo sapiens', unos primates descubren un monolito que los conduce a un estadio de inteligencia superior. Millones de años después, otro monolito, enterrado en una luna, despierta el interés de los científicos. Por último, durante una misión de la NASA, HAL 9000, una máquina dotada de inteligencia artificial, se encarga de controlar todos los sistemas de una nave espacial tripulada.",
            price: "0.5",
            location:(Localization(latitude: 21.3, longitude: 22.5)),
            dtstart: "27-10-2023",
            time: "22:00",
            eventLocation: "Biblioteca Pública ",
            link: URL(string: "https://google.com/"))))
    }
}
