//
//  DateFormatterHelper.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation
import SwiftDate

protocol DateFormatterProtocol {
    func dateFromString(_ string: String) -> String
    func displayRange(fromDates: (date1: Date, date2: Date)) -> String
    func monthTitle(_ date: Date) -> String
    func isInSameMonth(date1: Date, date2: Date) -> Bool
}

final class DateFormatterHelper: DateFormatterProtocol {
    func dateFromString(_ string: String) -> String {
        ""
    }

    func displayRange(fromDates: (date1: Date, date2: Date)) -> String {
        ""
    }

    func monthTitle(_ date: Date) -> String {
        ""
    }

    func isInSameMonth(date1: Date, date2: Date) -> Bool {
        false
    }

}
