//
//  URLSessionsExtension.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation

extension URLSession: NetworkFetchingProtocol {
    func data(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await data(for: urlRequest)
    }
}
