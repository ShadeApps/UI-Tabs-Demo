//
//  NetworkClient.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Alamofire
import Foundation

enum NetworkError: Error {
    case urlIsIncorrect
    case somethingWrong
    case connection
}

protocol NetworkClientProtocol {
    func request<T: Decodable>(path: String, parameters: [String: Any]?, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkClient: NetworkClientProtocol {
    func request<T: Decodable>(path: String, parameters: [String: Any]? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let urlString = Constants.base + "/" + path
        let request = AF.request(urlString, parameters: parameters, headers: [Constants.authKey: Constants.authValue])

        if request.error?.isCreateURLRequestError != nil {
            completion(.failure(NetworkError.urlIsIncorrect))
        }

        request.responseDecodable(of: T.self) { response in
            if let error = response.error?.underlyingError {
                if let err = error as? URLError,
                   err.code == .notConnectedToInternet {
                    completion(.failure(NetworkError.connection))
                } else {
                    completion(.failure(NetworkError.somethingWrong))
                }
                return
            }

            guard let value = response.value else {
                return completion(.failure(NetworkError.somethingWrong))
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
