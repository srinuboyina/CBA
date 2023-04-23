//
//  MapViewControllerTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 16/04/23.
//

import XCTest
import MapKit
@testable import CommBankAssignmentSkeleton

final class MapViewControllerTests: XCTestCase {
    
    var controller: MapViewController!
    let atm = ATM(id: "129382", name: "Circular Quay Station", address: "8 Alfred St, Sydney, NSW 2000", location: Location(lat: -33.861382, lng: 151.210316))
    
    override func setUp() {
        controller = MapViewController()
        controller.atm = atm
        controller.addAnnotation(atm: ATM(id: "234", name: "test", address: "Location", location: Location(lat: -33.861382, lng: 151.210316)))
    }
    
    func testMap() {
        XCTAssertNotNil(controller.mapView)
    }
    
    func testAnnotation() {
        XCTAssertTrue(controller.mapView.annotations.count > 0)
    }
    
    func testViewDidLoad() {
        controller.viewDidLoad()
        XCTAssertNotNil(controller.view)
    }
    
    func testMapViewDelegate() {
        let annotation = MKPointAnnotation()
        annotation.title = "Circular Quay Station 8 Alfred St, Sydney, NSW 2000"
        let annotationView = controller.mapView(controller.mapView, viewFor: annotation)
        XCTAssertNotNil(annotationView)
    }
    
    func testAnnotationName() {
        let annotation = MKPointAnnotation()
        annotation.title = atm.name + " " + atm.address
        let annotationView = controller.mapView(controller.mapView, viewFor: annotation)
        
        let expectedTitle = annotationView?.annotation?.title
        let actualTitle = atm.name + " " + atm.address
        
        XCTAssertEqual(expectedTitle, actualTitle)
    }
}
