//
//  RootViewController.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import Pageboy
import Tabman
import TinyConstraints
import UIKit

final class RootViewController: TabmanViewController {

    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private var navigationControls: [UIView]!
    @IBOutlet private weak var topNavigationConstraint: NSLayoutConstraint!
    @IBOutlet private weak var navigationHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tabView: UIView!

    enum Tab {
        case upcoming, archived, options
    }

    private let upcomingVC = R.storyboard.main.upcomingVC()!
    private let archivedVC = R.storyboard.main.archivedVC()!
    private let optionsVC = R.storyboard.main.optionsVC()!

    private var initialTab = Tab.upcoming
    private let bar = TMBarView<TMHorizontalBarLayout, TopBarButton, BarIndicatorView>()

    private var viewControllers: [UIViewController] {
        [upcomingVC, archivedVC, optionsVC]
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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

        navigationHeightConstraint.constant = UIViewController.topNotchHeight + Constants.navigationHeight

        view.backgroundColor = Color.backgroundColor()!
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 0
        bar.backgroundView.style = .clear

        dataSource = self
        delegate = self

        addBar(bar, dataSource: self, at: .custom(view: tabView, layout: nil))
    }

    private func prepareTabs() {
        // Account for all devices
        if UIViewController.hasTopNotch {
            upcomingVC.topInset = UIViewController.topNotchHeight + Constants.navigationHeight
        } else {
            upcomingVC.topInset = Constants.navigationHeight + Constants.tabHeight
        }

        upcomingVC.didScrollCallback = { [weak self] value in
            guard let self = self else { return }

            let height = value > 0
            let maxOffset = -Constants.navigationHeight
            let newValue = -value < maxOffset ? maxOffset : -value
            let threshold = value > Constants.navigationHeight / 2

            self.topNavigationConstraint.constant = height ? newValue : 0
            self.navigationControls.forEach { $0.alpha = threshold ? 0 : 1 }
        }
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
        switch initialTab {
        case .upcoming:
            return .first
        case .archived:
            return .next
        case .options:
            return .last
        }
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
