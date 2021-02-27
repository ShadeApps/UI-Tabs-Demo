//
//  RootEntity.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import DefaultCodable
import Foundation

struct RootEntity: JSONRepresentable {

    @Default<Empty>
    var items = [Entity]()

    enum CodingKeys: String, CodingKey {
        case items = "record"
    }
}
