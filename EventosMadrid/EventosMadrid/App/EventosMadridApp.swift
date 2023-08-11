//
//  EventosMadridApp.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 3/8/23.
//

import SwiftUI

@main
struct EventosMadridApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(rootViewModel: RootConfigurator.buildViewModel())
        }
    }
}
