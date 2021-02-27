//
//  TopBarButton.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import Tabman

final class TopBarButton: TMLabelBarButton {

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(for item: TMBarItemable, intrinsicSuperview: UIView?) {
        super.init(for: item, intrinsicSuperview: intrinsicSuperview)
        backgroundColor = .clear

        tintColor = Color.grayColor()!
        selectedTintColor = Color.accentColor()!

        font = Constants.titleFont
        selectedFont = Constants.titleFont
    }

}

private extension TopBarButton {

    enum Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 13, weight: .medium)
    }

}
