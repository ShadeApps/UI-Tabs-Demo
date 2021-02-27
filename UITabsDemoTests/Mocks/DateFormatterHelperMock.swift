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