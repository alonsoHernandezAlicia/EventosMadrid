//
//  RemoteDataSource.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation

enum NetworkError: Error, Equatable {
    case malformedURL
    case errorCode(Int?)
}

final class RemoteDataSource: RemoteDataSourceProtocol {
    
    private let session: NetworkFetchingProtocol
    private let server: String = "https://datos.madrid.es/egob/catalogo/206974-0-agenda-eventos-culturales-100.json"
    
    init(session: NetworkFetchingProtocol = URLSession.shared) {
        self.session = session
    }
    
    func getEvents() async throws -> [Event]? {
        guard let urlRequest = buildEventsListRequest() else {
            throw NetworkError.malformedURL
        }
        
        let (data, _) = try await session.data(urlRequest: urlRequest)
        
        let eventGraph = try JSONDecoder().decode(EventGraph.self, from: data)
        return eventGraph.events
    }
}

private extension RemoteDataSource {
    func buildEventsListRequest() -> URLRequest? {
        guard let url = URL(string: "\(server)") else {
            print("URL Error")
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
