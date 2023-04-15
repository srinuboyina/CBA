//
//  DateHeaderTableViewCell.swift
//  CommBankAssignmentSkeleton
//
//  Created by apple on 15/04/23.
//

import UIKit

class DateHeaderTableViewCell: UITableViewHeaderFooterView {
    
    let transactionDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    let transactionDateDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        lbl.textColor = .black
        lbl.textAlignment = .right
        return lbl
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureViews() {
        let placeholderStackView = UIStackView(arrangedSubviews: [transactionDateLabel, transactionDateDescriptionLabel])
        placeholderStackView.distribution = .fillProportionally
        placeholderStackView.axis = .horizontal
        placeholderStackView.spacing = 10
        placeholderStackView.translatesAutoresizingMaskIntoConstraints = false
        placeholderStackView.backgroundColor = UIColor(hexFromString: "FFCE00")
        contentView.backgroundColor = UIColor(hexFromString: "FFCE00")
        contentView.addSubview(placeholderStackView)
        placeholderStackView.heightAnchor.constraint(equalToConstant:30).isActive = true
        NSLayoutConstraint.activate([
            placeholderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            placeholderStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            placeholderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            placeholderStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            transactionDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
    func updateDateDatails(dateViewModel: DateViewModel) {
        transactionDateLabel.text = dateViewModel.dateInFormat
        transactionDateDescriptionLabel.text = dateViewModel.dateDetail
    }
}
