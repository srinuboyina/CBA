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
    func getSectionsCount() -> Int
    func getRowsCount(section: Int) -> Int
    func getDateViewModel(section: Int) -> DateViewModel
    func getTransactionViewModel(indexPath: IndexPath) -> TransactionViewModel
    func getAccountViewModel() -> AccountViewModel
    func getATM(atmId: String) -> ATM
    func groupTransactionsByDate()
    var groupedTransactions: [String: [Transaction]] {get set}
    func groupPendingTransactionsByDate()
    var groupedPendingTransactions: [String: [Transaction]] {get set}
}

class TransactionsViewModel: TransactionsViewModelProtocol {
    var network: Network!
    internal var accountData: AccountDetail?
    var groupedTransactions: [String: [Transaction]]  = [:]
    var groupedPendingTransactions: [String: [Transaction]] = [:]
    
    init(network: Network = NetworkManager()) {
        self.network = network
    }
    
    func getTrransactions( completionHandler: @escaping (() -> Void)) {
        network.fetchApiData(urlString: network.apiUrl) { [weak self] trans, error in
            self?.accountData = trans
            //self?.sortTransactionByDate()
            self?.groupTransactionsByDate()
            self?.groupPendingTransactionsByDate()
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
    
    func getTransactionViewModel(indexPath: IndexPath) -> TransactionViewModel {
        if indexPath.section <= groupedPendingTransactions.count {
            let keys = groupedPendingTransactions.map({ $0.key })
            let key = keys[indexPath.section - 1]
            if let transactions = groupedPendingTransactions[key]  {
                let transaction = transactions[indexPath.row]
                return PendingTransactionViewModel(transaction: transaction)
            }
        } else {
            let keys = groupedTransactions.map({ $0.key })
            let key = keys[indexPath.section - groupedPendingTransactions.count - 1]
            if let transactions =  groupedTransactions[key]  {
                let transaction  = transactions[indexPath.row]
                return TransactionViewModel(transaction: transaction)
            }
        }
        return TransactionViewModel(transaction: Transaction(id: "9a899bfd978511e9605774e1d5222b67", description: "Savings", effectiveDate: "19/12/2015", amount: -10.00, atmId: ""))
    }
    
    func getSectionsCount() -> Int {
        return groupedPendingTransactions.count  + groupedTransactions.count + 1
    }
    
    func getRowsCount(section: Int) -> Int {
        if section == 0 {
            return 0
        }
        if section <= groupedPendingTransactions.count {
            let keys = groupedPendingTransactions.map({ $0.key })
            let key = keys[section - 1]
            return groupedPendingTransactions[key]?.count ?? 0
        } else {
            let keys = groupedTransactions.map({ $0.key })
            let key = keys[section - groupedPendingTransactions.count - 1]
            return groupedTransactions[key]?.count ?? 0
        }
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
        self.groupedTransactions = groupByDate(transactions: accountData.transactions)
    }
    
    func groupPendingTransactionsByDate() {
        guard let accountData = self.accountData else { return }
        self.groupedPendingTransactions = groupByDate(transactions: accountData.pending)
    }
    
    private func groupByDate(transactions: [Transaction]) -> [String: [Transaction]] {
        let datesArray = transactions.map { $0.effectiveDate }
        var dic = [String:[Transaction]]()
        datesArray.forEach {
            let dateKey = $0
            let filterArray = transactions.filter { $0.effectiveDate == dateKey }
            dic[$0] = filterArray
        }
        return dic
    }
    
    func getDateViewModel(section: Int) -> DateViewModel {
        var date: String = ""
        if section == 0 {
            return DateViewModel(date: date)
        }
        if section <= groupedPendingTransactions.count {
            let keys = groupedPendingTransactions.map({ $0.key })
            date = keys[section - 1]
        } else {
            let keys = groupedTransactions.map({ $0.key })
            date = keys[section - groupedPendingTransactions.count - 1]
        }
        return DateViewModel(date: date)
    }
}

