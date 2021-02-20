//
//  TabbedController.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 20.02.2021.
//

import UIKit

public protocol TabbedController: UIViewController {

    var topInset: CGFloat { get set }
    var didScrollCallback: ((CGFloat) -> Void)? { get set }

}
