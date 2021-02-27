//
//  NetworkClientProtocol.swift
//  UITabsDemo
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation

protocol NetworkClientProtocol {

    func request<T: Decodable>(path: String, parameters: [String: Any]?, completion: @escaping (Result<T, NetworkError>) -> Void)

}
