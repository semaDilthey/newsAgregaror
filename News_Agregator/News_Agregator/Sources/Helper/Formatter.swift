//
//  Formatter.swift
//  News_Agregator
//
//  Created by Семен Гайдамакин on 13.02.2024.
//

import Foundation

enum Formatter {
    
    static func convertDateFormat(inputDate: String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let oldDate = olDateFormatter.date(from: inputDate)

        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd.MM HH:mm"
        convertDateFormatter.locale = Locale(identifier: "ru_RU")

        guard let oldDate else { return inputDate}
        return convertDateFormatter.string(from: oldDate)
        
   }
    
}
