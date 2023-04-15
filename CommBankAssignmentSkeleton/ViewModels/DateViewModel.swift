//
//  DateViewModel.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 15/04/23.
//

import Foundation

struct DateViewModel  {
    
    
    var date: String!
    
    var dateInFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/yyyy"
        if let dateTemp = dateFormatter2.date(from: date) {
            return dateFormatter.string(from: dateTemp)
        }
        return ""
    }
    
    var dateDetail: String {
        return Utilities.prepareDayDescription(date: date)
    }
}
