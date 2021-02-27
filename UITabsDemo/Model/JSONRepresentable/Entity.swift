//
//  Entity.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import DefaultCodable
import Foundation

struct Entity: JSONRepresentable {

    enum CostType: String, JSONRepresentable, DefaultValueProvider {
        case free
        case paid

        static let `default` = CostType.free
    }

    @Default<CostType>
    var cost: CostType
    let imageUrl: URL
    let location: String
    let venue: String
    let startTime: String
    let endTime: String

    enum CodingKeys: String, CodingKey {
        case imageUrl
        case cost
        case location
        case venue
        case startTime
        case endTime
    }
}

extension Entity: Equatable {

}
