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
    var useDelay = false

    private let dataService: LoadDataServiceProtocol
    private let dateFormatter: DateFormatterProtocol
    private var items = [EventContainer]()
    private var internalState = LoadState.empty

    // MARK: - Lifecycle
    init(dataService: LoadDataServiceProtocol = LoadDataService(), dateFormatter: DateFormatterProtocol = DateFormatterHelper()) {
        self.dataService = dataService
        self.dateFormatter = dateFormatter
    }
}

// MARK: - Load Data
extension ListViewModel {
    func loadData() {
        guard internalState != .isLoading else {
            return
        }

        internalState = .isLoading
        delegate?.reloadTableView(internalState)

        if useDelay {
            doAfter(Constants.loadDelay) {
                self.load()
            }
        } else {
            load()
        }
    }

    private func load() {
        dataService.request(path: Constants.path) {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.items.removeAll()
                self.groupData(from: value.items)
                self.internalState = self.items.isEmpty ? .empty : .success
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

// MARK: - Group Data
private extension ListViewModel {

    func groupData(from items: [Entity]) {
        var events = [Event]()

        for item in items {
            let start = self.dateFormatter.dateFromString(item.startTime)
            let end = self.dateFormatter.dateFromString(item.endTime)
            let event = Event(cost: item.cost,
                              imageUrl: item.imageUrl,
                              location: item.location,
                              venue: item.venue,
                              startTime: start,
                              endTime: end,
                              startDay: self.dateFormatter.displayDay(fromDate: start),
                              timeRange: self.dateFormatter.displayRange(fromDates: (start, end)))
            events.append(event)
        }

        events.sort { $0.startTime < $1.startTime }

        // Grouping  container logics
        var newContainer = EventContainer()

        for event in events {
            if let lastEvent = newContainer.events.last,
               !self.dateFormatter.isInSameMonth(date1: event.startTime, date2: lastEvent.startTime) {
                    self.addContainer(newContainer)
                    newContainer.events.removeAll()
                    self.addEvent(event, to: &newContainer)
                } else {
                self.addEvent(event, to: &newContainer)
            }
        }

        if !newContainer.events.isEmpty {
            self.addContainer(newContainer)
        }
    }

    func addEvent(_ event: Event, to newContainer: inout EventContainer) {
        newContainer.events.append(event)
        newContainer.startTime = event.startTime
        newContainer.timeDisplayString = self.dateFormatter.monthTitle(event.startTime)
    }

    func addContainer(_ container: EventContainer) {
        items.append(container)
    }
}

extension ListViewModel {

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
