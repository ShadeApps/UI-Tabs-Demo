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

    enum Tab {
        case upcoming, archived, options
    }

    let upcomingVC = R.storyboard.main.upcomingVC()!
    let archivedVC = R.storyboard.main.archivedVC()!
    let optionsVC = R.storyboard.main.optionsVC()!

    private let bar = TMBarView<TMHorizontalBarLayout, TopBarButton, BarIndicatorView>()

    private var viewControllers: [UIViewController] {
        [upcomingVC, archivedVC, optionsVC]
    }

    private var initialTab = Tab.upcoming

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        bar.layout.interButtonSpacing = 0
        bar.layout.contentMode = .fit
        addBar(bar, dataSource: self, at: .top)

        dataSource = self
        delegate = self
    }

    private func setupViews() {
        view.backgroundColor = Color.backgroundColor()!
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .clear
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
