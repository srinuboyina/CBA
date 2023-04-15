//
//  PendingTransactionViewModel.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 14/04/23.
//

import Foundation
import UIKit

class PendingTransactionViewModel: TransactionViewModel  {
    
    override func getDescription() ->  NSAttributedString {
        let normalText = transaction.description
        let boldText  = "PENDING: "
        let attributedString = NSMutableAttributedString(string:normalText)
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
        boldString.append(attributedString)
        return boldString
    }
}
