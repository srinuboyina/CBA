//
//  TransactionsViewModelStub.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 23/04/23.
//

import Foundation
@testable import CommBankAssignmentSkeleton

class TransactionsViewModelStub: TransactionsViewModelProtocol {
    
    init() {
        self.accountData = AccountDetail(account: builder.account, transactions: builder.transactions, pending: builder.pending, atms: builder.atms)
        self.groupedTransactions = ["23/04/2023": builder.transactions]
        self.groupedPendingTransactions = ["23/04/2023": builder.pending]
    }
    
    let builder = AccountDetailBuilder()
    var network: CommBankAssignmentSkeleton.Network! = MockNetworkManager()
 
    var accountData: CommBankAssignmentSkeleton.AccountDetail?
    
    var getTrransactionsCalled = false
    func getTrransactions(completionHandler: @escaping (() -> Void)) {
        getTrransactionsCalled = true
    }
    
    func getSectionsCount() -> Int {
        return groupedPendingTransactions.count  + groupedTransactions.count + 1
    }
    
    func getRowsCount(section: Int) -> Int {
        if section == 0 {
            return 0
        }
        if section <= groupedPendingTransactions.count {
            let keys = groupedPendingTransactions.map({ $0.key })
            let key = keys[section - 1]
            return groupedPendingTransactions[key]?.count ?? 0
        } else {
            let keys = groupedTransactions.map({ $0.key })
            let key = keys[section - groupedPendingTransactions.count - 1]
            return groupedTransactions[key]?.count ?? 0
        }
    }
    
    func getDateViewModel(section: Int) -> CommBankAssignmentSkeleton.DateViewModel {
        return DateViewModel(date: "23/04/2023")
    }
    
    func getTransactionViewModel(indexPath: IndexPath) -> CommBankAssignmentSkeleton.TransactionViewModel? {
        return  TransactionViewModel(transaction: TransactionBuilder().build())
    }
    
    func getAccountViewModel() -> CommBankAssignmentSkeleton.AccountViewModel? {
        return AccountViewModel(account: AccountDetailBuilder().account)
    }
    
    func getATM(atmId: String) -> CommBankAssignmentSkeleton.ATM? {
        return ATMBuilder().build()
    }
    
    var groupTransactionsByDateCalled = false
    func groupTransactionsByDate() {
        groupTransactionsByDateCalled = true
    }
    
    var groupedTransactions: [String : [CommBankAssignmentSkeleton.Transaction]]
    
    var groupPendingTransactionsByDateCalled = false
    func groupPendingTransactionsByDate() {
        groupPendingTransactionsByDateCalled = true
    }
    
    var groupedPendingTransactions: [String : [CommBankAssignmentSkeleton.Transaction]]
}
