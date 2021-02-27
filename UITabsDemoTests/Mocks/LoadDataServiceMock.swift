//
//  LoadDataServiceMock.swift
//  UITabsDemoTests
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation
import UIKit
@testable import UITabsDemo

final class LoadDataServiceMock: LoadDataServiceProtocol {
    var requestImagePath: String?
    var requestPath: String?
    var requestCounter = 0
    var requestImageCounter = 0
    
    var requestResult: Result<RootEntity, Error>!
    var requestImageResult: UIImage!
    
    func request(path: String, completion: @escaping (Result<RootEntity, Error>) -> Void) {
        self.requestPath = path
        self.requestCounter += 1
        completion(requestResult)
    }
    
    func requestImage(path: String, id: UUID, completion: @escaping (UIImage) -> Void) {
        self.requestImagePath = path
        self.requestImageCounter += 1
        completion(requestImageResult)
    }
}
