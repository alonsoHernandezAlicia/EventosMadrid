//
//  HomeView.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import SwiftUI



struct HomeView: View {
    
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(spacing: 0) {
                Text("MAD")
                    .padding(.top, 150)
                    .padding(.leading, 0)
                    .padding(.trailing, 0)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundStyle(.linearGradient(
                        colors: [ Color("SecondaryColor"), .accentColor],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                Text("Events")
                    .padding(.top, 150)
                    .padding(.leading, 0)
                    .padding(.trailing, 0)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("SecondaryColor"))
            }
            Spacer()
            Image("Home1")
                .resizable()
                .padding(
                    .init(top: 0,
                          leading: 20,
                          bottom: 250,
                          trailing: 20))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
