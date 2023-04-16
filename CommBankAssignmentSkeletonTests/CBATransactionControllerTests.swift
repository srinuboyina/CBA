//
//  CBATransactionControllerTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 16/04/23.
//

import XCTest
@testable import CommBankAssignmentSkeleton

final class CBATransactionControllerTests: XCTestCase {
    
    var controller: CBATransactionController!
    override func setUp() {
        controller = CBATransactionController()
        controller.loadViewIfNeeded()
    }
    
    func testDatasource() {
        XCTAssert(controller.conforms(to: UITableViewDataSource.self))
    }
    
    func testDelegate() {
        XCTAssert(controller.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableView(){
        XCTAssertNotNil(controller.tableView)
    }
    
    func testTableViewSectoins(){
        XCTAssertTrue(controller.tableView.numberOfSections > 0)
    }
    
    func testTableViewWHeader(){
        let view = controller.tableView(controller.tableView, viewForHeaderInSection: 0)
        XCTAssert(view is CBATransactionTableHeader)
    }
    
    func testTableViewZCell(){
        if controller.viewModel.groupedTransactions.count > 0 && controller.tableView.numberOfRows(inSection: 1) > 0  {
            if let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? TransactionTableViewCell {
                XCTAssertNotNil(cell.transactionAmountLabel)
                XCTAssertNotNil(cell.transactionDetailsLabel)
            }
        }
    }

}
