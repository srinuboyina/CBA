//
//  TransactionHeaderCell.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 14/04/23.
//

import UIKit

class TransactionHeaderCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var accountAccessLbl: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var availableFundsValue: UILabel!
    @IBOutlet weak var availableBalanceValue: UILabel!
    
    func updateAccountDetails(account: AccountViewModel) {
        accountAccessLbl.text = account.accountName
        accountNumber.text = account.accountNumber
        availableFundsValue.text = account.availableFunds
        availableBalanceValue.text = account.availableBalance
    }
    
}
