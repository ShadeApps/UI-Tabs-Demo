//
//  WrongStubsCell.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import UIKit

final class WrongStubsCell: UITableViewCell {

    weak var delegate: StubsCellDelegate?

    @IBAction func retryButtonPressed(_ sender: Any) {
        delegate?.retryClicked(self)
    }
}
