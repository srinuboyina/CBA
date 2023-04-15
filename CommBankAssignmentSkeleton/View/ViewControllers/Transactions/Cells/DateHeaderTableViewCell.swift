//
//  DateHeaderTableViewCell.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 15/04/23.
//

import UIKit

class DateHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionDateDescriptionLabel: UILabel!
 
    func updateDateDatails(dateViewModel: DateViewModel) {
        transactionDateLabel.text = dateViewModel.date
        transactionDateDescriptionLabel.text = dateViewModel.dateDetail
    }
}
