//
//  PendingTransactionViewModelTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 14/04/23.
//

import XCTest
@testable import CommBankAssignmentSkeleton

class PendingTransactionViewModelTests: XCTestCase {
    let transaction = Transaction(id: "9a899bfd978511e9605774e1d5222b67", description: "Savings", effectiveDate: "19/12/2015", amount: -10.00, atmId: "129382")
    var transactionViewModel: PendingTransactionViewModel!
    
    override func setUp() {
        transactionViewModel  = PendingTransactionViewModel(transaction: transaction)
    }
    
    func testDescription() {
        XCTAssertTrue(transactionViewModel.getDescription().string.contains("PENDING:"))
    }
}
