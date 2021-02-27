//
//  LoadDataService.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation
import UIKit

typealias LoadResult = Result<RootEntity, Error>

protocol LoadDataServiceProtocol {
    func request(path: String, completion: @escaping (LoadResult) -> Void)
}

final class LoadDataService: LoadDataServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }

    func request(path: String, completion: @escaping (LoadResult) -> Void) {
        self.networkClient.request(path: path, completion: completion)
    }
}
