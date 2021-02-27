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
        XCTAssert(viewModel.sections.count == 2)
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
        XCTAssert(viewModel.sections.count == 2)
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
}

private extension UITabsDemoTests {
    
    enum Constants {
        static let path = "602ce0c15605851b065e96e1"
    }
    
}

