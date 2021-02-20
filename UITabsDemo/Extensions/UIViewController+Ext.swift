//
//  UIViewController+Ext.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import UIKit

extension UIViewController {
    func showError(message: String? = nil) {
        let alert = UIAlertController(title: Localizable.errorTitle().capitalized,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localizable.ok().capitalized, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    static var hasTopNotch: Bool {
        if let delegate = UIApplication.shared.delegate, let window = delegate.window {
            return (window?.safeAreaInsets.top ?? 0) > CGFloat(20)
        }
        return false
    }

    static var topNotchHeight: CGFloat {
        if let delegate = UIApplication.shared.delegate, let window = delegate.window {
            return window?.safeAreaInsets.top ?? 0
        }
        return 0
    }
}
