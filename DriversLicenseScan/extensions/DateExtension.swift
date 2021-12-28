//
//  DateIntervalExtension.swift
//  DateIntervalExtension
//
//  Created by Gardner von Holt on 8/6/21.
//

import Foundation

extension Date {

    var zeroSeconds: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: dateComponents)!
    }

    func hmString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        let str = dateFormatter.string(from: self)
        return str
    }

    func dmString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        dateFormatter.locale = Locale.current
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }

    func dmyString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = Locale.current
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }

    func ymdString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMM d"
        dateFormatter.locale = Locale.current
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }

    func dmyhmString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = Locale.current
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }

    func dowString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMM yyyy"
        dateFormatter.locale = Locale.current
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }

    func eeeeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale.current
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }

    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }

    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

    func dateByAdding(days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: self)
    }

    func dateByAdding(hours: Int) -> Date? {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)
    }

    func dateByAdding(minutes: Int) -> Date? {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)
    }

    func isAfter(_ other: Date) -> Bool {
        if self > other { return true } else { return false }
    }

    static func fromComponents(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date {
        let userCalendar = Calendar.current
        var generatedDateComponents = DateComponents()
        generatedDateComponents.year = year
        generatedDateComponents.month = month
        generatedDateComponents.day = day
        generatedDateComponents.hour = hour
        generatedDateComponents.minute = minute
        generatedDateComponents.second = second
        let generatedDate = userCalendar.date(from: generatedDateComponents)!
        return generatedDate
    }
}
