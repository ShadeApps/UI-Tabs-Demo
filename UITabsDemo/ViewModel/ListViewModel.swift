//
//  ListViewModel.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation

enum LoadState {
    case isLoading
    case success
    case empty
    case error
    case noConnection
}

protocol ListViewModelDelegate: AnyObject {
    func reloadTableView(_ state: LoadState)
    func showError(_ state: LoadState)
}

final class ListViewModel {
    weak var delegate: ListViewModelDelegate?

    private let dataService: LoadDataServiceProtocol
    private let dateFormatter: DateFormatterProtocol
    private var items = [EventContainer]()
    private var internalState = LoadState.empty

    init(dataService: LoadDataServiceProtocol = LoadDataService(), dateFormatter: DateFormatterProtocol = DateFormatterHelper()) {
        self.dataService = dataService
        self.dateFormatter = dateFormatter
    }

    func loadData() {
        guard internalState != .isLoading else {
            return
        }

        internalState = .isLoading
        delegate?.reloadTableView(internalState)

        doAfter(Constants.loadDelay) {
            self.dataService.request(path: Constants.path) {  [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    let items = value.items
                    print("Items are \(items)")

                    self.internalState = items.isEmpty ? .empty : .success
                    self.delegate?.reloadTableView(self.internalState)
                case .failure(let error):
                    if error == .connection {
                        self.internalState = .noConnection
                    } else {
                        self.internalState = .error
                    }
                    self.delegate?.showError(self.internalState)
                }
            }
        }
    }

    var numberOfSections: Int {
        if case .success = internalState {
            return sections.count
        } else {
            return 1
        }
    }

    func numberOfItems(inSection section: Int) -> Int {
        if case .success = internalState {
            return sectionAtIndex(section).events.count + Constants.extraCount
        } else {
            return 5
        }
    }

    var sections: [EventContainer] {
        items
    }

    func sectionAtIndex(_ index: Int) -> EventContainer {
        items[index]
    }

    func itemAtIndex(section: Int, index: Int) -> Event? {
        items[safe: section]?.events[safe: index]
    }
}

private extension ListViewModel {

    enum Constants {
        static let path = "602ce0c15605851b065e96e1"
        static let extraCount = 2
        static let loadDelay = 2.0
    }

}
