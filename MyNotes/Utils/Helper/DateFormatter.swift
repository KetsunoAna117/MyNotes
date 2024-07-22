//
//  DateFormatter.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 22/07/24.
//

import Foundation

struct DateHelper {
    static func formatDate(_ date: Date) -> String {
        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()

        // Set the date format
        dateFormatter.dateFormat = "EEEE, dd-MM-yyyy 'at' HH:mm:ss"

        // Set the locale to ensure the day names are in English
        dateFormatter.locale = Locale(identifier: "en_US")

        // Get the current date and time
        let currentDate = date

        // Format the current date
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return formattedDate
    }
}
