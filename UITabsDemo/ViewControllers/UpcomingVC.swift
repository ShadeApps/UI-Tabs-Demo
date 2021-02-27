//
//  UpcomingVC.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import UIKit

final class UpcomingVC: UIViewController, TabbedController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = ListViewModel()
    private var viewState = LoadState.isLoading

    var topInset = CGFloat(0)
    var didScrollCallback: ((CGFloat) -> Void)?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

        viewModel.delegate = self
        viewModel.loadData()
    }
}

// MARK: - Table View
extension UpcomingVC: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 20, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(R.nib.mainCell)
        tableView.register(R.nib.separatorCell)
        tableView.register(R.nib.skeletonCell)
        tableView.register(R.nib.monthHeaderCell)
        tableView.register(R.nib.emptyStubsCell)
        tableView.register(R.nib.wrongStubsCell)
        tableView.register(R.nib.connectionStubsCell)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellFor(indexPath)
    }
}

// MARK: - CellForRowAt Logics
extension UpcomingVC {

    private func cellFor(_ indexPath: IndexPath) -> UITableViewCell {
        switch viewState {
        case .success:
            return successCellFor(indexPath)
        case .empty:
            if indexPath.row == 0 {
                return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.emptyStubsCell, for: indexPath)!
            }
        case .error:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.wrongStubsCell, for: indexPath)!
                cell.delegate = self
                return cell
            }
        case .noConnection:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.connectionStubsCell, for: indexPath)!
                cell.delegate = self
                return cell
            }
        default:
            break
        }

        return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.skeletonCell, for: indexPath)!
    }

    private func successCellFor(_ indexPath: IndexPath) -> UITableViewCell {
        guard case .success = viewState else {
            return UITableViewCell()
        }

        let rowIndex = indexPath.row

        if rowIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.monthHeaderCell, for: indexPath)!
            cell.layoutWith(month: viewModel.sectionAtIndex(indexPath.section).timeDisplayString)
            return cell
        }

        if let event = viewModel.itemAtIndex(section: indexPath.section, index: rowIndex - 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mainCell, for: indexPath)!
            cell.layoutWith(event: event)
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.separatorCell, for: indexPath)!
        }
    }

}

// MARK: - ViewModel Delegate
extension UpcomingVC: ListViewModelDelegate {
    func reloadTableView(_ state: LoadState) {
        viewState = state
        tableView.isScrollEnabled = true
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        tableView.reloadData()
    }

    func showError(_ state: LoadState) {
        viewState = state
        tableView.isScrollEnabled = false
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        tableView.reloadData()
        HapticHelper.vibrate(.error)
    }
}

// MARK: - TabbedController Callback
extension UpcomingVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollCallback?(scrollView.contentOffset.y + topInset)
    }
}

// MARK: - Cell Delegate
extension UpcomingVC: StubsCellDelegate {
    func retryClicked(_ cell: UITableViewCell) {
        HapticHelper.vibrate(.light)
        viewModel.loadData()
    }
}
