//
//  DateFormatterHelper.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation
import SwiftDate

final class DateFormatterHelper: DateFormatterProtocol {
    private let formatter = DateFormatter()

    private let apiFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd HH:mm:ss", options: 0, locale: nil)
    private let rangeFormat = DateFormatter.dateFormat(fromTemplate: "h:mm a", options: 0, locale: Locale(identifier: "en_US_POSIX"))
    private let monthFormat = DateFormatter.dateFormat(fromTemplate: "MMMM", options: 0, locale: Locale(identifier: "en_US_POSIX"))

    func dateFromString(_ string: String) -> Date {
        formatter.dateFormat = apiFormat
        return formatter.date(from: string) ?? Date()
    }

    func displayDay(fromDate: Date) -> String {
        formatter.dateFormat = monthFormat
        return fromDate.ordinalDay + " " + formatter.string(from: fromDate)
    }

    func displayRange(fromDates: (date1: Date, date2: Date)) -> String {
        formatter.dateFormat = rangeFormat

        let secondComponent = "— " + formatter.string(from: fromDates.date2)
        var value = formatter.string(from: fromDates.date1) + " " + secondComponent

        // TO DO: think of a better way to do it
        let pmComponents = value.components(separatedBy: "PM")

        if pmComponents.count > 2 {
            value = pmComponents.first! + secondComponent
        }

        let amComponents = value.components(separatedBy: "AM")

        if amComponents.count > 2 {
            value = amComponents.first! + secondComponent
        }

        return value
    }

    func monthTitle(_ date: Date) -> String {
        formatter.dateFormat = monthFormat
        return formatter.string(from: date)
    }

    func isInSameMonth(date1: Date, date2: Date) -> Bool {
        date1.isInside(date: date2, granularity: .month)
    }

}
