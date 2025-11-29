//
//  Date+Formatted.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import Foundation

extension Date {

    func formattedDateTimeInTimezone(_ timezone: String) -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "EEEE, HH:mm"

          if let tz = TimeZone(identifier: timezone) {
              formatter.timeZone = tz
          }

          return formatter.string(from: self)
      }

    func formattedTime(timezone: String) -> String {
        guard let tz = TimeZone(identifier: timezone) else {
            return Date().formatted(date: .omitted, time: .shortened)
        }

        let formatter = DateFormatter()
        formatter.timeZone = tz
        formatter.dateFormat = "HH:mm"

        return formatter.string(from: Date())
    }
}
