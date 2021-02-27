//
//  DateFormatterProtocol.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation

protocol DateFormatterProtocol {
    func dateFromString(_ string: String) -> Date
    func displayDay(fromDate: Date) -> String
    func displayRange(fromDates: (date1: Date, date2: Date)) -> String
    func monthTitle(_ date: Date) -> String
    func isInSameMonth(date1: Date, date2: Date) -> Bool
}
