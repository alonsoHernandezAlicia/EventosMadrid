//
//  NetworkFetchingProtocol.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//

import Foundation

protocol NetworkFetchingProtocol {
    func data(urlRequest: URLRequest) async throws  -> (Data, URLResponse)
}
