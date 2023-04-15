//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import UIKit

class CBATransactionController: UIViewController {
    var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    var viewModel: TransactionsViewModelProtocol = TransactionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Account Details"
        setupTableView()
        registerCells()
        
        self.viewModel.getTrransactions { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionFooterHeight = 0.1
        tableView.accessibilityLabel = "TransactionsTableView"
    }
    
    private func registerCells() {
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        tableView.register(CBATransactionTableHeader.self, forHeaderFooterViewReuseIdentifier: "CBATransactionTableHeader")
        tableView.register(DateHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: "DateHeaderTableViewCell")
    }
}

extension CBATransactionController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionsCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowsCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transViewModel: TransactionViewModel = viewModel.getTransactionViewModel(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as? TransactionTableViewCell
        cell?.delegate = self
        cell?.updateTransactionDetail(viewModel: transViewModel)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CBATransactionTableHeader") as? CBATransactionTableHeader  {
                headerView.updateAccountDetails(account: viewModel.getAccountViewModel())
                return headerView
            }
        } else if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateHeaderTableViewCell") as? DateHeaderTableViewCell {
            let viewModel = viewModel.getDateViewModel(section: section)
            header.updateDateDatails(dateViewModel: viewModel)
            return header
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return Constants.TransactionsTableViewConstants.headerHeight
        } else {
            return Constants.TransactionsTableViewConstants.dateHeaderHeight
        }
    }
    
}

extension CBATransactionController:  LocationDelegate {
    func locationClicked(atmId: String) {
        let mapController = MapViewController()
        mapController.atm = viewModel.getATM(atmId: atmId)
        self.navigationController?.pushViewController(mapController, animated: true)
    }
}
