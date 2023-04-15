//
//  TransactionTableViewCell.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 14/04/23.
//

import UIKit

protocol LocationDelegate: AnyObject {
    func locationClicked(atmId: String)
}

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transactionDetailsLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    weak var delegate: LocationDelegate?
    var viewModel:TransactionViewModel!
    
    func updateTransactionDetail(viewModel: TransactionViewModel) {
        self.viewModel = viewModel
        self.transactionAmountLabel.text = viewModel.amount
        self.transactionDetailsLabel.attributedText = viewModel.getDescription()
        if let _ = viewModel.atmId {
            locationButton.isHidden  = false
            widthConstraint.constant = 16
        } else {
            locationButton.isHidden  = true
            widthConstraint.constant = 0
        }
    }
    
    @IBAction func locationClicked() {
        if let atmId = viewModel.atmId  {
            delegate?.locationClicked(atmId: atmId)
        }
    }
    
}
