//
//  UIImageView+Ext.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import Kingfisher

extension UIImageView {
    func loadImage(url: URL, placeholder: UIImage? = nil) {
        kf.setImage(with: url, placeholder: placeholder)
    }
}
