//
//  DateFormatterHelperMock.swift
//  UITabsDemoTests
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation
@testable import UITabsDemo

final class DateFormatterHelperMock: DateFormatterProtocol {
    var resultString = ""
    var formatterIsInvokedCounter = 0
    
    func displayRange(fromDates: (date1: Date, date2: Date)) -> String {
        formatterIsInvokedCounter += 1
        return DateFormatterHelper().displayRange(fromDates: fromDates)
    }
    
    func monthTitle(_ date: Date) -> String {
        formatterIsInvokedCounter += 1
        return DateFormatterHelper().monthTitle(date)
    }
    
    func isInSameMonth(date1: Date, date2: Date) -> Bool {
        formatterIsInvokedCounter += 1
        return DateFormatterHelper().isInSameMonth(date1: date1, date2: date2)
    }
    
    func dateFromString(_ string: String) -> Date {
        formatterIsInvokedCounter += 1
        return Date()
    }
    
    func displayDay(fromDate: Date) -> String {
        formatterIsInvokedCounter += 1
        return DateFormatterHelper().displayDay(fromDate: fromDate)
    }
}
