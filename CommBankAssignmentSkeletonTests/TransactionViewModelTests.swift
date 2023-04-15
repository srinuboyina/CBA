//
//  TransactionViewModelTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 14/04/23.
//

import XCTest
@testable import CommBankAssignmentSkeleton

class TransactionViewModelTests: XCTestCase {
    let transaction = Transaction(id: "9a899bfd978511e9605774e1d5222b67", description: "Savings", effectiveDate: "19/12/2015", amount: -10.00, atmId: "")
    var transactionViewModel: TransactionViewModel!
    
    override func setUp() {
        transactionViewModel  = TransactionViewModel(transaction: transaction)
    }
    
    func testAmount() {
        XCTAssert(transactionViewModel.amount == "-$10.0")
    }
    
    func testDateDescription() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let dateObj = dateFormatter.date(from: transaction.effectiveDate) {
            let difference =  Date() - dateObj
            XCTAssert(transactionViewModel.dateDescription ==  "\(difference.day!) Days Ago")
        }
    }
}

