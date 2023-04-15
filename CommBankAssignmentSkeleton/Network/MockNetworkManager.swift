//
//  MockNetworkManager.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 14/04/23.
//

import Foundation

struct MockNetworkManager: Network {
    var apiUrl: String!
    init()  {
        if let path = Bundle.main.path(forResource: "sample", ofType: "json") {
            self.apiUrl = path
        }
        self.apiUrl = ""
    }
}
