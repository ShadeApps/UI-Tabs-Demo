//
//  LoadDataServiceProtocol.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation

protocol LoadDataServiceProtocol {
    func request(path: String, completion: @escaping (LoadResult) -> Void)
}
