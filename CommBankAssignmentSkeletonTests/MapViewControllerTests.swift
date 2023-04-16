//
//  MapViewControllerTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 16/04/23.
//

import XCTest
@testable import CommBankAssignmentSkeleton

final class MapViewControllerTests: XCTestCase {
    
    var controller: MapViewController!
    override func setUp() {
        controller = MapViewController()
        controller.addAnnotation(atm: ATM(id: "234", name: "test", address: "Location", location: Location(lat: -33.861382, lng: 151.210316)))
    }
    
    func testMap() {
        XCTAssertNotNil(controller.mapView)
    }
    
    func testAnnotation() {
        XCTAssertTrue(controller.mapView.annotations.count > 0)
    }
}
