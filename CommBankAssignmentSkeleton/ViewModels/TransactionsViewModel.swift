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
    func getTransactionViewModel(indexPath: IndexPath) -> TransactionViewModel?
    func getAccountViewModel() -> AccountViewModel?
    func getATM(atmId: String) -> ATM?
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
    
    let dateFormatter = DateFormatter()
    
    init(network: Network = NetworkManager()) {
        self.network = network
        dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    
    func getTrransactions(completionHandler: @escaping (() -> Void)) {
        network.fetchApiData(urlString: network.apiUrl) { [weak self] trans, error in
            self?.accountData = trans
            self?.groupTransactionsByDate()
            self?.groupPendingTransactionsByDate()
            completionHandler()
        }
    }
    
    private func sortTransactionByDate()  {
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
    
    func getTransactionViewModel(indexPath: IndexPath) -> TransactionViewModel? {
        if indexPath.section <= groupedPendingTransactions.count {
            let keys = groupedPendingTransactions.map({ $0.key }).sorted { key1, key2 in
                dateFormatter.date(from:key1)!.compare(dateFormatter.date(from:key2)!) == .orderedDescending
            }
            let key = keys[indexPath.section - 1]
            if let transactions = groupedPendingTransactions[key]  {
                let transaction = transactions[indexPath.row]
                return PendingTransactionViewModel(transaction: transaction)
            }
        } else {
            let keys = groupedTransactions.map({ $0.key }).sorted { key1, key2 in
                dateFormatter.date(from:key1)!.compare(dateFormatter.date(from:key2)!) == .orderedDescending
            }
            let key = keys[indexPath.section - groupedPendingTransactions.count - 1]
            if let transactions = groupedTransactions[key]  {
                let transaction = transactions[indexPath.row]
                return TransactionViewModel(transaction: transaction)
            }
        }
        return nil
    }
    
    func getSectionsCount() -> Int {
        return groupedPendingTransactions.count  + groupedTransactions.count + 1
    }
    
    func getRowsCount(section: Int) -> Int {
        if section == 0 {
            return 0
        }
        if section <= groupedPendingTransactions.count {
            let keys = groupedPendingTransactions.map({ $0.key }).sorted { key1, key2 in
                dateFormatter.date(from:key1)!.compare(dateFormatter.date(from:key2)!) == .orderedDescending
            }
            let key = keys[section - 1]
            return groupedPendingTransactions[key]?.count ?? 0
        } else {
            let keys = groupedTransactions.map({ $0.key }).sorted { key1, key2 in
                dateFormatter.date(from:key1)!.compare(dateFormatter.date(from:key2)!) == .orderedDescending
            }
            let key = keys[section - groupedPendingTransactions.count - 1]
            return groupedTransactions[key]?.count ?? 0
        }
    }
    
    func getAccountViewModel() -> AccountViewModel? {
        if let account = accountData?.account {
            return AccountViewModel(account: account)
        }
        return nil
    }
    
    func getATM(atmId: String) -> ATM?  {
        if let atm =  accountData?.atms.first(where: { atm in
            return atm.id ==   atmId
        }) {
            return  atm
        }
        return nil
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
    
    func sortWithKeys(_ dict: [String: [Transaction]]) -> [String: [Transaction]] {
        let sorted = dict.sorted(by: { dateFormatter.date(from:$0.key)!.compare(dateFormatter.date(from:$1.key)!) == .orderedDescending })
        var newDict: [String: [Transaction]] = [:]
        for sortedDict in sorted {
            newDict[sortedDict.key] = sortedDict.value
        }
        return newDict
    }
    
    func getDateViewModel(section: Int) -> DateViewModel {
        var date: String = ""
        if section == 0 {
            return DateViewModel(date: date)
        }
        if section <= groupedPendingTransactions.count {
            let keys = groupedPendingTransactions.map({ $0.key }).sorted { key1, key2 in
                dateFormatter.date(from:key1)!.compare(dateFormatter.date(from:key2)!) == .orderedDescending
            }
            date = keys[section - 1]
        } else {
            let keys = groupedTransactions.map({ $0.key }).sorted { key1, key2 in
                dateFormatter.date(from:key1)!.compare(dateFormatter.date(from:key2)!) == .orderedDescending
            }
            date = keys[section - groupedPendingTransactions.count - 1]
        }
        return DateViewModel(date: date)
    }
}

