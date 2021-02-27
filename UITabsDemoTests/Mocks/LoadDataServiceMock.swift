//
//  LoadDataServiceMock.swift
//  UITabsDemoTests
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation
@testable import UITabsDemo

final class LoadDataServiceMock: LoadDataServiceProtocol {
    var requestPath: String?
    var requestCounter = 0
    var requestImageCounter = 0
    
    var requestResult: LoadResult!
    
    func request(path: String, completion: @escaping (LoadResult) -> Void) {
        self.requestPath = path
        self.requestCounter += 1
        completion(requestResult)
    }
}
