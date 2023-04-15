//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import UIKit

class CBATransactionController: UIViewController {
    
    var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    var viewModel: TransactionsViewModelProtocol = TransactionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.title = "Account Details"
        setupTableView()
        registerCells()
        
        self.viewModel.getTrransactions { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
        tableView.register(UINib(nibName: "TransactionHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "TransactionHeaderCell")
    }
}

extension CBATransactionController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transViewModel: TransactionViewModel = viewModel.getTransactionViewModel(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as? TransactionTableViewCell
        cell?.delegate = self
        cell?.updateTransactionDetail(viewModel: transViewModel)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TransactionHeaderCell") as? TransactionHeaderCell {
            header.updateAccountDetails(account: viewModel.getAccountViewModel())
            return header
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.TableConstants.headerHeight
    }
    
}

extension CBATransactionController:  LocationDelegate {
    func locationClicked(atmId: String) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let mapController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            mapController.atm  = viewModel.getATM(atmId: atmId)
            self.navigationController?.pushViewController(mapController, animated: true)
            _ = mapController.view
        }
    }
}
