//
//  UITabsDemoTests.swift
//  UITabsDemoTests
//
//  Created by Sergey Grischyov on 19.02.2021.
//

@testable import UITabsDemo
import XCTest
import DefaultCodable

final class UITabsDemoTests: XCTestCase {
    enum NetworkErrorStub: Error {
        case error
    }

    private let mockService: LoadDataServiceMock = LoadDataServiceMock()
    private let dateFormatter: DateFormatterHelperMock = DateFormatterHelperMock()
    private let delegateMock: ListViewModelDelegateMock = ListViewModelDelegateMock()
    func initialTestingViewModel() -> ListViewModel {
        let viewModel = ListViewModel(dataService: mockService, dateFormatter: dateFormatter)
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
        XCTAssert(dateFormatter.resultString == "")
        XCTAssert(dateFormatter.formatterIsInvokedCounter == 0)
        XCTAssert(delegateMock.reloadingCounter == 2)
        XCTAssert(delegateMock.errorCounter == 0)
        XCTAssert(mockService.requestCounter == 1)
        XCTAssert(mockService.requestPath == Constants.path)
        XCTAssert(viewModel.sections.count == 0)
    }

    func testLoadDataItems() throws {
        // GIVEN
        let viewModel = initialTestingViewModel()
        let defaultType = Default<ModelCostType>()
        let entities = [
            Entity(cost: defaultType, imageUrl: URL(string: "https://images.unsplash.com/photo-1491333078588-55b6733c7de6")!, location: "", venue: "", startTime: "", endTime: ""),
            Entity(cost: defaultType, imageUrl: URL(string: "https://images.unsplash.com/photo-1491333078588-55b6733c7de6")!, location: "", venue: "", startTime: "", endTime: "")
        ]
        // WHEN
        self.mockService.requestResult = .success(RootEntity(items: entities))
        viewModel.loadData()
        // THEN
        XCTAssert(dateFormatter.resultString == "")
        XCTAssert(dateFormatter.formatterIsInvokedCounter == 4)
        XCTAssert(delegateMock.reloadingCounter == 2)
        XCTAssert(delegateMock.errorCounter == 0)
        XCTAssert(mockService.requestCounter == 1)
        XCTAssert(mockService.requestPath == Constants.path)
        XCTAssert(viewModel.sections.count == 1)
    }

    func testLoadDataItemsTwice() throws {
        // GIVEN
        let viewModel = initialTestingViewModel()
        let defaultType = Default<ModelCostType>()
        let entities = [
            Entity(cost: defaultType, imageUrl: URL(string: "https://images.unsplash.com/photo-1491333078588-55b6733c7de6")!, location: "", venue: "", startTime: "", endTime: ""),
            Entity(cost: defaultType, imageUrl: URL(string: "https://images.unsplash.com/photo-1491333078588-55b6733c7de6")!, location: "", venue: "", startTime: "", endTime: "")
        ]
        // WHEN
        self.mockService.requestResult = .success(RootEntity(items: entities))
        viewModel.loadData()
        self.mockService.requestResult = .success(RootEntity(items: entities))
        viewModel.loadData()
        // THEN
        XCTAssert(dateFormatter.resultString == "")
        XCTAssert(dateFormatter.formatterIsInvokedCounter == 8)
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
        mockService.requestResult = .failure(NetworkErrorStub.error)
        viewModel.loadData()
        // THEN
        XCTAssert(dateFormatter.resultString == "")
        XCTAssert(dateFormatter.formatterIsInvokedCounter == 0)
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

