//
//  MockEntityProvider.swift
//  UITabsDemoTests
//
//  Created by Sergey Grischyov on 28.02.2021.
//

import Foundation
@testable import UITabsDemo
import DefaultCodable

struct MockEntityProvider {
    
    var mockEntities: [Entity] {
        let defaultType = Default<ModelCostType>()
        return [
            Entity(cost: defaultType, imageUrl: URL(string: "https://images.unsplash.com/photo-1491333078588-55b6733c7de6")!, location: "", venue: "", startTime: "", endTime: ""),
            Entity(cost: defaultType, imageUrl: URL(string: "https://images.unsplash.com/photo-1491333078588-55b6733c7de6")!, location: "", venue: "", startTime: "", endTime: "")
        ]
    }
    
}

