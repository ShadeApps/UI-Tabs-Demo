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
    
    func dateFromString(_ string: String) -> String {
        formatterIsInvokedCounter += 1
        return ""
    }
    
    func displayRange(fromDates: (date1: Date, date2: Date)) -> String {
        formatterIsInvokedCounter += 1
        return ""
    }
    
    func monthTitle(_ date: Date) -> String {
        formatterIsInvokedCounter += 1
        return ""
    }
    
    func isInSameMonth(date1: Date, date2: Date) -> Bool {
        formatterIsInvokedCounter += 1
        return false
    }
}
