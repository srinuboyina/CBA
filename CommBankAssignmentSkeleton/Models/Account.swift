//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import Foundation

// MARK: - AccountDetail
struct AccountDetail: Decodable {
    let account: Account
    var transactions: [Transaction]
    var pending: [Transaction]
    let atms: [ATM]
}

// MARK: - Account
struct Account: Decodable {
    let accountName: String
    let accountNumber: String
    let available: Double
    let balance: Double
}

// MARK: - ATM
struct ATM: Decodable {
    let id: String
    let name: String
    let address: String
    let location: Location
}

// MARK: - Location
struct Location: Decodable {
    let lat: Double
    let lng: Double
}

// MARK: - Pending
struct Transaction: Decodable {
    let id: String
    let description: String
    let effectiveDate: String
    let amount: Double
    let atmId: String?
}
