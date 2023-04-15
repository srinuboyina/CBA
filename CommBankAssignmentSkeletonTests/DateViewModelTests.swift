//
//  DateViewModelTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 15/04/23.
//

import XCTest
@testable import CommBankAssignmentSkeleton

class DateViewModelTests: XCTestCase {
    
    var dateViewModel:  DateViewModel!
    
    override func setUp()  {
        dateViewModel  =  DateViewModel(date: "22/10/2022")
    }
    
    func testDateInformat() {
        XCTAssert(dateViewModel.dateInFormat == "22 Oct 2022")
    }
}
