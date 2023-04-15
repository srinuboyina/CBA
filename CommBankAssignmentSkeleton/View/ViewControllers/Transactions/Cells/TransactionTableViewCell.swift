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

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    weak var delegate: LocationDelegate?
    var viewModel:TransactionViewModel!
    
    let transactionDetailsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.numberOfLines = 0
        lbl.textColor = .black
        return lbl
    }()
    
    let transactionAmountLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    let locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "FindUsIcon"), for: .normal)
        button.addTarget(self, action: #selector(locationClicked), for: .touchUpInside)
        return button
    }()
    
    func updateTransactionDetail(viewModel: TransactionViewModel) {
        self.viewModel = viewModel
        self.transactionAmountLabel.text = viewModel.amount
        self.transactionDetailsLabel.attributedText = viewModel.getDescription()
        if let _ = viewModel.atmId {
            self.accessibilityLabel = "Map"
            locationButton.accessibilityLabel =  "Map button"
            locationButton.isHidden  = false
            widthConstraint.constant = 16
        } else {
            locationButton.isHidden  = true
            widthConstraint.constant = 0
        }
    }
    
    @objc func locationClicked() {
        if let atmId = viewModel.atmId  {
            delegate?.locationClicked(atmId: atmId)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureViews() {
        let placeholderStackView = UIStackView(arrangedSubviews: [locationButton, transactionDetailsLabel, transactionAmountLabel])
        placeholderStackView.distribution = .equalSpacing
        placeholderStackView.axis = .horizontal
        placeholderStackView.spacing = 16
        placeholderStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(placeholderStackView)
        widthConstraint = locationButton.widthAnchor.constraint(equalToConstant: 16)
        widthConstraint.isActive = true

        NSLayoutConstraint.activate([
            placeholderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            placeholderStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            placeholderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            placeholderStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    
}
