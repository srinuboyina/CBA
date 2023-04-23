//
//  NetworkTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 23/04/23.
//

import XCTest
@testable import CommBankAssignmentSkeleton

final class NetworkTests: XCTestCase {
    
    var network: NetworkManager!
    
    override func setUp() {
      network = NetworkManager()
    }
    
    func testGetTransactions() {
//        let expectation = self.expectation(description: "fetch accoout details and transaction data should return AccountDetail model")
//        network.fetchApiData(urlString: network.apiUrl) { trans, error in
//            XCTAssertNotNil(trans)
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 3, handler: nil)
    }
}

