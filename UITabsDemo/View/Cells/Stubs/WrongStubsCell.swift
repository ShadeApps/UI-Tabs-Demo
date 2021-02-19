//
//  WrongStubsCell.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import UIKit

protocol WrongStubsCellDelegate: class {
    func retryRefreshClicked(_ cell: WrongStubsCell)
}

final class WrongStubsCell: UITableViewCell {

    weak var delegate: WrongStubsCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func retryButtonPressed(_ sender: Any) {
        delegate?.retryRefreshClicked(self)
    }
}
