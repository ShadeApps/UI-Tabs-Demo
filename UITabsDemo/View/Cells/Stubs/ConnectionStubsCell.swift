//
//  ConnectionStubsCell.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import UIKit

protocol StubsCellDelegate: class {
    func retryClicked(_ cell: UITableViewCell)
}

final class ConnectionStubsCell: UITableViewCell {

    weak var delegate: StubsCellDelegate?

    @IBAction func retryButtonPressed(_ sender: Any) {
        delegate?.retryClicked(self)
    }
}
