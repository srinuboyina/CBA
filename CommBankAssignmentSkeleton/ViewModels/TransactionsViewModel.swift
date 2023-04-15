//
//  TransactionsViewModel.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 14/04/23.
//

import Foundation

protocol TransactionsViewModelProtocol {
    var network: Network! { get set }
    var accountData: AccountDetail? { get set }
    func getTrransactions( completionHandler: @escaping (() -> Void))
    func getRowsCount() -> Int
    func getTransactionViewModel(index: Int) -> TransactionViewModel
    func getAccountViewModel() -> AccountViewModel
    func getATM(atmId: String) -> ATM
    func groupTransactionsByDate()
}

class TransactionsViewModel: TransactionsViewModelProtocol {
    var network: Network!
    internal var accountData: AccountDetail?
    var groupedTransactions: [String: [Transaction]]  = [:]
    
    init(network: Network = NetworkManager()) {
        self.network = network
    }
    
    func getTrransactions( completionHandler: @escaping (() -> Void)) {
        network.fetchApiData(urlString: network.apiUrl) { [weak self] trans, error in
            self?.accountData = trans
            self?.sortTransactionByDate()
            completionHandler()
        }
    }
    
    private func sortTransactionByDate()  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        accountData?.transactions.sort(by: { tran1, tran2 in
            if let date1 =  dateFormatter.date(from: tran1.effectiveDate),
                let date2 =  dateFormatter.date(from: tran2.effectiveDate) {
                return date1.compare(date2) ==  .orderedDescending
            }
            return tran1.effectiveDate > tran2.effectiveDate
        })
        
        accountData?.pending.sort(by: { tran1, tran2 in
            if let date1 =  dateFormatter.date(from: tran1.effectiveDate),
                let date2 =  dateFormatter.date(from: tran2.effectiveDate) {
                return date1.compare(date2) ==  .orderedDescending
            }
            return tran1.effectiveDate > tran2.effectiveDate
        })
    }
    
    func getTransactionViewModel(index: Int) -> TransactionViewModel {
        guard let accountData = self.accountData else { return  TransactionViewModel(transaction: Transaction(id: "", description: "", effectiveDate: "", amount: 0, atmId: ""))}
        if index < accountData.pending.count {
            let transaction = accountData.pending[index]
            return PendingTransactionViewModel(transaction: transaction)
        } else {
            let transaction = accountData.transactions[index]
            return TransactionViewModel(transaction: transaction)
        }
    }
    
    func getRowsCount() -> Int {
        return accountData?.transactions.count ?? 0  + (accountData?.pending.count ?? 0)
    }
    
    func getAccountViewModel() -> AccountViewModel {
        let account = accountData?.account ??  Account(accountName: "", accountNumber: "", available: 0, balance: 0)
        return AccountViewModel(account: account)
    }
    
    func getATM(atmId: String) -> ATM  {
        if let atm =  accountData?.atms.first(where: { atm in
            return atm.id ==   atmId
        }) {
            return  atm
        }
        return ATM(id: "", name: "", address: "", location: Location(lat: 0, lng: 0))
    }
    
    func groupTransactionsByDate()  {
        guard let accountData = self.accountData else { return }
        let datesArray = accountData.transactions.map { $0.effectiveDate }
        var dic = [String:[Transaction]]()
        datesArray.forEach {
            let dateKey = $0
            let filterArray = accountData.transactions.filter { $0.effectiveDate == dateKey }
            dic[$0] = filterArray
        }
        self.groupedTransactions = dic
    }
}

