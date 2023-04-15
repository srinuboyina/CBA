//
//  TransactionsViewModelTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 14/04/23.
//

import XCTest
@testable import CommBankAssignmentSkeleton

class TransactionsViewModelTests: XCTestCase {
    var transactionsViewModel: TransactionsViewModel!
    
    override func setUp() {
        transactionsViewModel = TransactionsViewModel(network: MockNetworkManager())
    }
    
    func testGetTransactions()  {
        transactionsViewModel.getTrransactions {
            XCTAssertNotNil(self.transactionsViewModel.accountData)
            if let accountData = self.transactionsViewModel.accountData {
                XCTAssert(accountData.transactions.count == 13)
                XCTAssert(accountData.pending.count == 2)
                XCTAssert(accountData.atms.count == 2)
                XCTAssert(accountData.account.accountName == "Complete Access")
            }
        }
    }
}
