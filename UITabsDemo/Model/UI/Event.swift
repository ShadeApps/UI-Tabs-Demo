//
//  Event.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation

typealias ModelCostType = Entity.CostType

struct Event {
    var cost: ModelCostType
    let imageUrl: URL
    let location: String
    let venue: String
    let startTime: Date
    let endTime: Date
    let startDay: String
    let timeRange: String
}
