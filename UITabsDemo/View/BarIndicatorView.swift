//
//  BarIndicatorView.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import Tabman

final class BarIndicatorView: TMBarIndicator {

    override var displayMode: TMBarIndicator.DisplayMode {
        .bottom
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init() {
        super.init()

        let line = UIView()
        addSubview(line)

        line.height(Constants.lineHeight)
        line.width(Constants.lineWidth)
        line.bottomToSuperview()
        line.centerInSuperview()

        line.backgroundColor = Color.accentColor()!
    }

}

private extension BarIndicatorView {

    enum Constants {
        static let lineHeight = CGFloat(2)
        static let lineWidth = CGFloat(24)
    }

}
