//
//  RemoteDataSourceProtocol.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 7/8/23.
//


import Foundation

protocol RemoteDataSourceProtocol {
    func getEvents() async throws -> [Event]?
}
