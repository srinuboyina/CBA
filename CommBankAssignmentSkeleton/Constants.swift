//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import Foundation

enum Constants {
    enum ApiConstant {
        //Api endpoint to get the the transaction response
        static let transactionsUrl = "https://www.dropbox.com/s/tewg9b71x0wrou9/data.json?dl=1"
        static let mockPath = Bundle.main.path(forResource: "sample", ofType: "json")
    }
    
    enum StringConstant {
        static let available_funds = "Available Funds"

        static let available_balance = "Available Balance"
    }
    
    enum TransactionsTableViewConstants {
        static let headerHeight: CGFloat = 200
        static let dateHeaderHeight: CGFloat = 30
    }
}
