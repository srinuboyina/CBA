//
//  AccountViewModel.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 14/04/23.
//

import Foundation

class AccountViewModel {
    private var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    var accountName: String {
        account.accountName
    }
    
    var accountNumber: String {
        account.accountNumber
    }
    
    var availableFunds: String {
        "\(account.available)"
    }
    
    var availableBalance: String {
        "\(account.balance)"
    }
}
