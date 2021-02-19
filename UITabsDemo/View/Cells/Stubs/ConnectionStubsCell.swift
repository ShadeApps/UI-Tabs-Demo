//
//  ConnectionStubsCell.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import UIKit

protocol ConnectionStubsCellDelegate: class {
    func retryConnectionClicked(_ cell: ConnectionStubsCell)
}

final class ConnectionStubsCell: UITableViewCell {

    weak var delegate: ConnectionStubsCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func retryButtonPressed(_ sender: Any) {
        delegate?.retryConnectionClicked(self)
    }
}
