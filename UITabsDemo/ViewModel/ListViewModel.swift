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
    case noConnection
    case error
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

        dataService.request(path: Constants.path) {  [weak self] (result: LoadResult) in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                let items = value.items
                print("Items are \(items)")

                self.internalState = items.isEmpty ? .empty : .success
                self.delegate?.reloadTableView(self.internalState)
            case .failure(let error):
                print("Error is \(error)")
                self.internalState = .error
                self.delegate?.showError(self.internalState)
            }
        }
    }

    var numberOfSections: Int {
        switch internalState {
        case .success:
            return sections.count
        default:
            return 1
        }
    }

    func numberOfItems(inSection section: Int) -> Int {
        switch internalState {
        case .success:
            return sectionAtIndex(section).events.count
        default:
            return 5
        }
    }

    var sections: [EventContainer] {
        items
    }

    func sectionAtIndex(_ index: Int) -> EventContainer {
        items[index]
    }

    func itemAtIndex(_ indexPath: IndexPath) -> Event {
        items[indexPath.section].events[indexPath.row]
    }
}

private extension ListViewModel {

    enum Constants {
        static let path = "602ce0c15605851b065e96e1"
    }

}
