//
//  TransactionBuiler.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by apple on 23/04/23.
//

import Foundation
@testable import CommBankAssignmentSkeleton

class TransactionBuilder {
    var id: String = "87f6f9d078c3bc5db5578f3b4add9470"
    var description: String = "Credit Interest"
    var effectiveDate: String = "3/11/2015"
    var amount: Double = 0.02
    var atmId: String? = "129382"
    var isPending: Bool? = false
    
    func with(id: String) -> TransactionBuilder {
        self.id = id
        return self
    }
    
    func with(description: String) -> TransactionBuilder {
        self.description = description
        return self
    }
    
    func with(effectiveDate: String) -> TransactionBuilder {
        self.effectiveDate = effectiveDate
        return self
    }
    
    func with(amount: Double) -> TransactionBuilder {
        self.amount = amount
        return self
    }
    
    func with(isPending: Bool) -> TransactionBuilder {
        self.isPending = isPending
        return self
    }
    
    func build() -> Transaction {
        return Transaction(id: id, description: description, effectiveDate: effectiveDate, amount: amount, atmId: atmId)
    }
}
