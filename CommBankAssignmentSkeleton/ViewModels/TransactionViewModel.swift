//
//  TransactionViewModel.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 14/04/23.
//

import Foundation

protocol TransactionViewModelProtocol  {
    var amount: String  {get set}
    var dateDescription: String {get set}
    var date: String {get set}
    var transaction: Transaction! {get set}
    func getDescription() ->  AttributedString
    var atmId: String? {get set}
}

class TransactionViewModel {
    var amount: String
    var dateDescription: String
    var date: String
    var transaction: Transaction!
    var atmId: String?
    
    init(transaction: Transaction) {
        self.transaction = transaction
        self.amount = "$" + String(transaction.amount)
        if transaction.amount  < 0 {
            self.amount = "-$" + String(abs(transaction.amount))
        }
        self.date = transaction.effectiveDate
        self.dateDescription = Utilities.prepareDayDescription(date: transaction.effectiveDate)
        self.atmId = transaction.atmId
    }
    
    func getDescription() -> NSAttributedString {
        return NSAttributedString(string: transaction.description)
    }
}
