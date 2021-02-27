//
//  MonthHeaderCell.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import UIKit

final class MonthHeaderCell: UITableViewCell {

    @IBOutlet weak var monthLabel: UILabel!

    func layoutWith(month: String) {
        monthLabel.text = month.uppercased()
    }
}
