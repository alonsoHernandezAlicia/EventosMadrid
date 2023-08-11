//
//  Utils.swift
//  EventosMadrid
//
//  Created by Alonso Hernández Alicia on 9/8/23.
//

import Foundation

final class Utils {
    
    static func parseEventDate(dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        dateFormatter.locale = Locale(identifier: "es_ES")
        
        guard let date = dateFormatter.date(from: dateTime) else { return "" }
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
}
