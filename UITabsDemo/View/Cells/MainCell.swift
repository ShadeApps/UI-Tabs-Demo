//
//  MainCell.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 19.02.2021.
//

import Kingfisher
import UIKit

final class MainCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var placeImage: UIImageView!

    func layoutWith(event: Event) {
        statusLabel.text = event.cost.rawValue.uppercased()
        dateLabel.text = event.startDay
        timeLabel.text = event.timeRange
        districtLabel.text = event.venue
        placeLabel.text = event.location
        placeImage.loadImage(url: event.imageUrl)
    }
}
