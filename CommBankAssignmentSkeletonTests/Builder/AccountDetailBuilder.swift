//
//  AccountDetailBuilder.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 23/04/23.
//

import Foundation
@testable import CommBankAssignmentSkeleton

class AccountDetailBuilder {
    let account: Account = AccountBuilder().build()
    let atms: [ATM] = [ATMBuilder().build(),
                       ATMBuilder().with(id: "23874").with(location: LocationBuilder().with(lat: 73.23).with(lng: 87.23).build()).build()]
    var transactions: [Transaction] = [TransactionBuilder().build(),
                                       TransactionBuilder().with(id: "87f6f9d078j3bc5db5578f3b4add9470").with(description: "transaction description").with(amount: 23.23).with(effectiveDate: "12/12/2018").build()]
    var pending: [Transaction] = [TransactionBuilder().with(id: "87f6f9d078j3bc5db5578f3b4adu7470").with(description: "pending transaction description").with(amount: 23.03).with(effectiveDate: "12/02/2018").with(isPending: true).build()]
}

class AccountBuilder {
    let accountName: String = "Complete Access"
    let accountNumber: String = "062005 1709 5888"
    let available: Double = 226.76
    let balance: Double = 246.76
    
    func build() -> Account {
        return Account(accountName: accountName, accountNumber: accountNumber, available: available, balance: balance)
    }
}
