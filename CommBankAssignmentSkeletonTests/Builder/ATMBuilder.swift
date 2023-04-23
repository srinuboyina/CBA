//
//  ATMBuilder.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 23/04/23.
//

import Foundation
@testable import CommBankAssignmentSkeleton

class ATMBuilder {
    var id: String = "129382"
    var name: String = "Circular Quay Station"
    var address: String = "8 Alfred St, Sydney, NSW 2000"
    var location: Location = LocationBuilder().build()
    
    func with(id: String) -> ATMBuilder {
        self.id = id
        return self
    }
    
    func with(name: String) -> ATMBuilder {
        self.name = name
        return self
    }
    func with(address: String) -> ATMBuilder {
        self.address = address
        return self
    }
    
    func with(location: Location) -> ATMBuilder {
        self.location = location
        return self
    }
    
    func build() -> ATM {
        return ATM(id: id, name: name, address: address, location: location)
    }
}

class LocationBuilder {
    var lat: Double = -33.861382
    var lng: Double = 151.210316
    
    func with(lat: Double) -> LocationBuilder {
        self.lat = lat
        return self
    }
    
    func with(lng: Double) -> LocationBuilder {
        self.lng = lng
        return self
    }
    
    func build() -> Location {
        return Location(lat: lat, lng: lng)
    }
}
