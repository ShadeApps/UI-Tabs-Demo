//
//  UpcomingVC.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import UIKit

final class UpcomingVC: UIViewController, TabbedController {

    @IBOutlet weak var tableView: UITableView!

    var topInset = CGFloat(0)
    var didScrollCallback: ((CGFloat) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.backgroundColor()!
        setupTableView()
    }
}

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
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.monthHeaderCell, for: indexPath)!
            cell.layoutWith(month: "APRIL")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mainCell, for: indexPath)!
            cell.layoutWith(imageURL: URL(string: "https://media-cdn.tripadvisor.com/media/photo-s/03/12/f8/3a/the-penny-farthing.jpg")!, statusText: "PAID", dateText: "16th May", timeText: "6:30 — 8:00 PM", districtText: "Brooklyn", placeText: "Nets Pub")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.separatorCell, for: indexPath)!
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.skeletonCell, for: indexPath)!
            return cell

        default:
            return UITableViewCell()
        }
    }
}

extension UpcomingVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollCallback?(scrollView.contentOffset.y + topInset)
    }
}

extension UpcomingVC: ConnectionStubsCellDelegate {
    func retryConnectionClicked(_ cell: ConnectionStubsCell) {
    }
}

extension UpcomingVC: WrongStubsCellDelegate {
    func retryRefreshClicked(_ cell: WrongStubsCell) {
    }
}
