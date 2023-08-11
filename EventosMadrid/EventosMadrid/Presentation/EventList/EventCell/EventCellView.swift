//
//  EventCellView.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import SwiftUI


struct EventCellView: View {
    
    var event: Event
    @State private var imageName = "Home1"
    
    private let didTapOnFavorite: () -> Void
    
    init(event: Event, didTapOnFavorite: @escaping () -> Void) {
        self.event = event
        self.didTapOnFavorite = didTapOnFavorite
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(event.title)
                    .fontWeight(.semibold)
                    .font(.headline)
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(.bottom, 1)
                Text(event.description)
                    .font(.caption)
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(3)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button {
                    didTapOnFavorite()
                } label: {
                    if event.favorite ?? false {
                        Image(systemName: "star.fill")
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color("AccentColor"))
                            .multilineTextAlignment(.center)
                        
                    } else {
                        Image(systemName: "star")
                            //.resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color("AccentColor"))
                            .multilineTextAlignment(.center)
                    }
                }
                
                if (event.price == "") {
                    Text("Gratis")
                        .font(.caption)
                } else {
                    Text(event.price)
                        .font(.system(size: 12))
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}


struct EventCellView_Previews: PreviewProvider {
    static var previews: some View {
        EventCellView(
            event: Event(
                id: "2",
                title: "2001: Una odisea del espacio",
                description:"Hace millones de años, antes de la aparición del 'homo sapiens', unos primates descubren un monolito que los conduce a un estadio de inteligencia superior. Millones de años después, otro monolito, enterrado en una luna, despierta el interés de los científicos. Por último, durante una misión de la NASA, HAL 9000, una máquina dotada de inteligencia artificial, se encarga de controlar todos los sistemas de una nave espacial tripulada.",
                price: "0.5",
                location:(Localization(latitude: 21.3, longitude: 22.5)),
                dtstart: "27-10-2023",
                time: "22:00",
                eventLocation: "Cineteca",
                link: URL(string: "https://google.com/")
            ), didTapOnFavorite: {}
        )
    }
}
