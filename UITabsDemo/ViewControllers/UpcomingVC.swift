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
        // viewModel.loadData()
    }
}

// MARK: - Table View
extension UpcomingVC: UITableViewDelegate, UITableViewDataSource {

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 20, right: 0)
        tableView.register(R.nib.mainCell)
        tableView.register(R.nib.separatorCell)
        tableView.register(R.nib.skeletonCell)
        tableView.register(R.nib.monthHeaderCell)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewState {
        case .isLoading:
            return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.skeletonCell, for: indexPath)!
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - ViewModel Delegate
extension UpcomingVC: ListViewModelDelegate {
    func reloadTableView(_ state: LoadState) {
        viewState = state
        tableView.isScrollEnabled = true
        tableView.setContentOffset(.zero, animated: true)
        tableView.reloadData()
    }

    func showError(_ state: LoadState) {
        viewState = state
        tableView.isScrollEnabled = false
        tableView.setContentOffset(.zero, animated: true)
        tableView.reloadData()
    }
}

// MARK: - TabbedController Callback
extension UpcomingVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollCallback?(scrollView.contentOffset.y + topInset)
    }
}

// MARK: - Cell Delegates
extension UpcomingVC: ConnectionStubsCellDelegate {
    func retryConnectionClicked(_ cell: ConnectionStubsCell) {
    }
}

extension UpcomingVC: WrongStubsCellDelegate {
    func retryRefreshClicked(_ cell: WrongStubsCell) {
    }
}
