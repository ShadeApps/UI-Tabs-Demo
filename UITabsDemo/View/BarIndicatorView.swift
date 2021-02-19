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
        line.bottomToSuperview()
        line.centerInSuperview()
        line.height(2)
        line.width(24)
        line.backgroundColor = Color.accentColor()!
    }

}
