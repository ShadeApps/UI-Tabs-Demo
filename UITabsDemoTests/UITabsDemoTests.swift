//
//  UITabsDemoTests.swift
//  UITabsDemoTests
//
//  Created by Sergey Grischyov on 19.02.2021.
//

@testable import UITabsDemo
import XCTest

final class UITabsDemoTests: XCTestCase {

    private let mockService: LoadDataServiceMock = LoadDataServiceMock()
    private let dateFormatterMock: DateFormatterHelperMock = DateFormatterHelperMock()
    private let mockEntityProvider: MockEntityProvider = MockEntityProvider()
    private let delegateMock: ListViewModelDelegateMock = ListViewModelDelegateMock()
    
    func initialTestingViewModel() -> ListViewModel {
        let viewModel = ListViewModel(dataService: mockService, dateFormatter: dateFormatterMock)
        viewModel.delegate = delegateMock
        return viewModel
    }

    func testEmptyLoadData() throws {
        // GIVEN
        let viewModel = initialTestingViewModel()
        // WHEN
        self.mockService.requestResult = .success(RootEntity(items: []))
        viewModel.loadData()
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 0)
        XCTAssert(delegateMock.reloadingCounter == 2)
        XCTAssert(delegateMock.errorCounter == 0)
        XCTAssert(mockService.requestCounter == 1)
        XCTAssert(mockService.requestPath == Constants.path)
        XCTAssert(viewModel.sections.count == 0)
    }

    func testLoadDataItems() throws {
        // GIVEN
        let viewModel = initialTestingViewModel()
        let entities = mockEntityProvider.mockEntities
        // WHEN
        self.mockService.requestResult = .success(RootEntity(items: entities))
        viewModel.loadData()
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 11)
        XCTAssert(delegateMock.reloadingCounter == 2)
        XCTAssert(delegateMock.errorCounter == 0)
        XCTAssert(mockService.requestCounter == 1)
        XCTAssert(mockService.requestPath == Constants.path)
        XCTAssert(viewModel.sections.count == 1)
    }

    func testLoadDataItemsTwice() throws {
        // GIVEN
        let viewModel = initialTestingViewModel()
        let entities = mockEntityProvider.mockEntities
        // WHEN
        self.mockService.requestResult = .success(RootEntity(items: entities))
        viewModel.loadData()
        self.mockService.requestResult = .success(RootEntity(items: entities))
        viewModel.loadData()
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 22)
        XCTAssert(delegateMock.reloadingCounter == 4)
        XCTAssert(delegateMock.errorCounter == 0)
        XCTAssert(mockService.requestCounter == 2)
        XCTAssert(mockService.requestPath == Constants.path)
        XCTAssert(viewModel.sections.count == 1)
    }

    func testLoadDataItemsFail() throws {
        // GIVEN
        let viewModel = initialTestingViewModel()
        // WHEN
        mockService.requestResult = .failure(.somethingWrong)
        viewModel.loadData()
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 0)
        XCTAssert(delegateMock.reloadingCounter == 1)
        XCTAssert(delegateMock.errorCounter == 1)
        XCTAssert(mockService.requestCounter == 1)
        XCTAssert(mockService.requestPath == Constants.path)
        XCTAssert(viewModel.sections.count == 0)
    }
    
    func testFormatterIsEmptyOnDateFromString() throws {
        // GIVEN
        let formatter = dateFormatterMock
        // WHEN
        let result = formatter.dateFromString("")
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 1)
        XCTAssert(result.dateComponents.isValidDate)
    }
    
    func testFormatterIsNotEmptyOnDisplayDay() throws {
        // GIVEN
        let formatter = dateFormatterMock
        // WHEN
        let result = formatter.displayDay(fromDate: Date())
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 1)
        XCTAssert(!result.isEmpty)
    }
    
    func testFormatterIsNotEmptyOnMonth() throws {
        // GIVEN
        let formatter = dateFormatterMock
        // WHEN
        let result = formatter.monthTitle(Date())
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 1)
        XCTAssert(!result.isEmpty)
    }
    
    func testFormatterSameDatesInSameMonth() throws {
        // GIVEN
        let formatter = dateFormatterMock
        // WHEN
        let result = formatter.isInSameMonth(date1: Date(), date2: Date())
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 1)
        XCTAssert(result == true)
    }
    
    func testFormatterDifferentDatesInDifferentMonth() throws {
        // GIVEN
        let formatter = dateFormatterMock
        // WHEN
        let result = formatter.isInSameMonth(date1: Date(), date2: Date().dateByAdding(2, .month).date)
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 1)
        XCTAssert(result == false)
    }
    
    func testFormatterRangeIsNotEmpty() throws {
        // GIVEN
        let formatter = dateFormatterMock
        // WHEN
        let result = formatter.displayRange(fromDates: (Date(), Date()))
        // THEN
        XCTAssert(dateFormatterMock.resultString == "")
        XCTAssert(dateFormatterMock.formatterIsInvokedCounter == 1)
        XCTAssert(!result.isEmpty)
    }
}

private extension UITabsDemoTests {
    
    enum Constants {
        static let path = "602ce0c15605851b065e96e1"
    }
    
}

