//
//  SkeletonCell.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import ShimmerSwift
import TinyConstraints
import UIKit

final class SkeletonCell: UITableViewCell {

    @IBOutlet weak var rootView: UIView!

    private let shimmeringView = ShimmeringView()

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.insertSubview(shimmeringView, belowSubview: rootView)
        shimmeringView.edges(to: rootView)
        shimmeringView.contentView = rootView
        shimmeringView.isShimmering = true
    }

}
