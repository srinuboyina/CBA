//
//  DateViewModel.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 15/04/23.
//

import Foundation

struct DateViewModel  {
    var date: String!
    
    var dateDetail: String {
        return Utilities.prepareDayDescription(date: date)
    }
}
