//
//  NetworkClient.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Alamofire
import Foundation
import UIKit

protocol NetworkClientProtocol {
    func request<T: Decodable>(path: String, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkClient: NetworkClientProtocol {
    enum NetworkError: Error {
        case urlIsIncorrect
        case connection
    }

    func request<T: Decodable>(path: String, parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = Constants.base + "/" + path
        let request = AF.request(urlString, parameters: parameters, headers: [Constants.authKey: Constants.authValue])

        if request.error?.isCreateURLRequestError != nil {
            completion(.failure(NetworkError.urlIsIncorrect))
        }
        request.responseDecodable(of: T.self) { response in
            guard let value = response.value else {
                completion(.failure(NetworkError.connection))
                return
            }

            completion(.success(value))
        }
    }
}

private extension NetworkClient {

    enum Constants {
        static let base = "https://api.jsonbin.io/v3/b"
        static let authKey = "X-Master-Key"
        static let authValue = "$2b$10$UYzh11htUekIGiMu6E.L2uJNU7HQAhOd5moG2KA7Fr1LuiESICroq"
    }

}
