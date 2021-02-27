//
//  ListViewModelDelegateMock.swift
//  UITabsDemoTests
//
//  Created by Sergey Grischyov on 27.02.2021.
//

import Foundation
@testable import UITabsDemo

final class ListViewModelDelegateMock: ListViewModelDelegate {
    var reloadingCounter = 0
    var errorCounter = 0

    func reloadTableView(_ state: LoadState) {
        reloadingCounter += 1
    }
    
    func showError(_ state: LoadState) {
        errorCounter += 1
    }
}
