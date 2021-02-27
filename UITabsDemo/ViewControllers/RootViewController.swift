//
//  RootViewController.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import Pageboy
import Tabman
import UIKit

final class RootViewController: TabmanViewController {

    private enum Tab {
        case upcoming, archived, options
    }

    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private var navigationControls: [UIView]!
    @IBOutlet private weak var topNavigationConstraint: NSLayoutConstraint!
    @IBOutlet private weak var navigationHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tabView: UIView!
    private let topBar = DefaultBar()

    private let upcomingVC = Storyboard.main.upcomingVC()!
    private let archivedVC = Storyboard.main.archivedVC()!
    private let optionsVC = Storyboard.main.optionsVC()!

    private var viewControllers: [UIViewController] {
        [upcomingVC, archivedVC, optionsVC]
    }
}

// MARK: - Lifecycle
extension RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        prepareTabs()

        topBar.setUp()
        addBar(topBar, dataSource: self, at: .custom(view: tabView, layout: nil))
        navigationHeightConstraint.constant = UIViewController.topNotchHeight + Constants.navigationHeight
    }

    private func prepareTabs() {
        // Account for all devices
        var inset = UIViewController.topNotchHeight + Constants.navigationHeight

        if !UIViewController.hasTopNotch {
            inset = Constants.navigationHeight + Constants.tabHeight
        }

        upcomingVC.topInset = inset
        upcomingVC.didScrollCallback = { [weak self] value in
            guard let self = self else { return }

            let height = value > 0
            let maxOffset = -Constants.navigationHeight
            let newValue = -value < maxOffset ? maxOffset : -value
            let threshold = value > Constants.navigationHeight / 2

            self.topNavigationConstraint.constant = height ? newValue : 0
            self.navigationControls.forEach { $0.alpha = threshold ? 0 : 1 }
        }

        // PageboyViewControllerDataSource
        dataSource = self
    }
}

// MARK: - Tabs DataSource
extension RootViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        .next
    }
}

// MARK: - Tabs UI
extension RootViewController: TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: Localizable.upcoming())
        case 1:
            return TMBarItem(title: Localizable.archived())
        case 2:
            return TMBarItem(title: Localizable.options())
        default:
            fatalError("not supported")
        }
    }
}

private extension RootViewController {

    enum Constants {
        static let navigationHeight = CGFloat(44)
        static let tabHeight = CGFloat(40)
    }

}
