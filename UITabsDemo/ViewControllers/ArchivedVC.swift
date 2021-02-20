//
//  ArchivedVC.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import UIKit

final class ArchivedVC: UIViewController, TabbedController {

    var topInset = CGFloat(0)
    var didScrollCallback: ((CGFloat) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.backgroundColor()!
    }
}
