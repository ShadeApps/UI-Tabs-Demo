//
//  JSONRepresentable.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation

protocol JSONRepresentable: Codable {

    var encodedData: Data? { get }
    var encodedJSON: Any { get }

    init(_ encodedData: Data?) throws

}

extension JSONRepresentable {

    var encodedData: Data? {
        try? JSONEncoder().encode(self)
    }

    var encodedJSON: Any {
        guard let encodedData = encodedData else {
            return [:]
        }
        return (try? JSONSerialization.jsonObject(with: encodedData)) ?? [:]
    }

    init(_ encodedData: Data?) throws {
        guard let encodedData = encodedData else {
            fatalError("No data")
        }
        self = try JSONDecoder().decode(Self.self, from: encodedData)
    }

}
