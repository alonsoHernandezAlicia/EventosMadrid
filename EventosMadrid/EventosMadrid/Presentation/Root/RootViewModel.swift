//
//  RootViewModel.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation

enum Status {
    case none
    case loading
    case loaded
    case error(error: String)
}

final class RootViewModel: ObservableObject {
    let repository: RepositoryProtocol
    
    @Published var status = Status.loaded
        
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
}

