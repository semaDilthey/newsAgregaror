//
//  +Date.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 12.02.2024.
//

import Foundation

enum DateFormats : String {
    case short = "dd MM"
    case full = "dd MMM yyyy HH:mm"
}

extension Date {
    
    func formattedDateString(format: DateFormats) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format.rawValue
            dateFormatter.locale = Locale(identifier: "ru_RU")
            return dateFormatter.string(from: self)
        }
    
}
