//
//  AccountViewModelTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 14/04/23.
//

import Foundation

import XCTest
@testable import CommBankAssignmentSkeleton

class AccountViewModelTests: XCTestCase {
    
    var accountViewModel: AccountViewModel!
    
    override func setUp() {
        accountViewModel = AccountViewModel(account: Account(accountName: "Complete Access", accountNumber: "062005 1709 5888", available: 226.76, balance: 246.76))
    }
    
    func testAccountName() {
        XCTAssert(accountViewModel.accountName == "Complete Access")
    }
    
    func testAccountNumber() {
        XCTAssert(accountViewModel.accountNumber == "062005 1709 5888")
    }
    
    func testAvailableFunds() {
        XCTAssert(accountViewModel.availableFunds == "226.76")
    }
    
    func testAvailableBalance() {
        XCTAssert(accountViewModel.availableBalance == "246.76")
    }
}
