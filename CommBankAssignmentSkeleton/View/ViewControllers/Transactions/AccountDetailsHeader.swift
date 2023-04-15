//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import UIKit

class CBATransactionTableHeader: UITableViewHeaderFooterView {

    let accountView: UIView = {
        let view = UIView()
//        view.backgroundColor =
        return view
    }()

    let accountInfoView: UIView = {
        let view = UIView()
//        view.backgroundColor =
        return view
    }()

    let walletImg : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .center
        return imgView
    }()

    let accountAccessLbl: UILabel = {
        let lbl = UILabel()
//        lbl.textColor =
        lbl.font = Font.helveticaNeue_light18
        return lbl
    }()

    let accountNumber: UILabel = {
        let lbl = UILabel()
//        lbl.textColor = 
        lbl.font = Font.helveticaNeue_light16
        return lbl
    }()

    let availableFunds: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.StringConstant.available_funds
//        lbl.textColor =
        lbl.font = Font.helveticaNeue_light16
        lbl.textAlignment = .left
        return lbl
    }()

    let availableBalance: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.StringConstant.available_balance
//        lbl.textColor =
        lbl.font = Font.helveticaNeue_light16
        lbl.textAlignment = .left
        return lbl
    }()

    let availableFundsValue: UILabel = {
        let lbl = UILabel()
//        lbl.textColor =
        lbl.font = Font.helveticaNeue_Bold16
        lbl.textAlignment = .right
        return lbl
    }()

    let availableBalanceValue: UILabel = {
        let lbl = UILabel()
//        lbl.textColor =
        lbl.font = Font.helveticaNeue_Bold16
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
//        contentView.backgroundColor = 

        let placeholderStackView = UIStackView(arrangedSubviews: [accountView, accountInfoView])
        placeholderStackView.distribution = .fillEqually
        placeholderStackView.axis = .vertical
        placeholderStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(placeholderStackView)

        NSLayoutConstraint.activate([
            placeholderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            placeholderStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            placeholderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            placeholderStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])

        let accountStack = UIStackView(arrangedSubviews: [accountAccessLbl, accountNumber])
        accountStack.distribution = .fill
        accountStack.axis = .vertical
        accountStack.spacing = 5
        accountStack.translatesAutoresizingMaskIntoConstraints = false
        walletImg.setContentHuggingPriority(UILayoutPriority.init(rawValue: 1000), for: .horizontal)

        let accountIconStack = UIStackView(arrangedSubviews: [walletImg, accountStack])
        accountIconStack.distribution = .fill
        accountIconStack.axis = .horizontal
        accountIconStack.spacing = 25
        accountIconStack.translatesAutoresizingMaskIntoConstraints = false
        accountView.addSubview(accountIconStack)

        NSLayoutConstraint.activate([
            accountIconStack.leadingAnchor.constraint(equalTo: accountView.leadingAnchor, constant: 10),
            accountIconStack.trailingAnchor.constraint(equalTo: accountView.trailingAnchor, constant: -10),
            accountIconStack.topAnchor.constraint(equalTo: accountView.topAnchor, constant: 10),
            accountIconStack.bottomAnchor.constraint(equalTo: accountView.bottomAnchor, constant: -15)
        ])

        let availableFundStack = UIStackView(arrangedSubviews: [availableFunds, availableFundsValue])
        availableFundStack.distribution = .fillEqually
        availableFundStack.axis = .horizontal

        let availableBalanceStack = UIStackView(arrangedSubviews: [availableBalance, availableBalanceValue])
        availableBalanceStack.distribution = .fillEqually
        availableBalanceStack.axis = .horizontal

        let accountInfoViewStack = UIStackView(arrangedSubviews: [availableFundStack, availableBalanceStack])
        accountInfoViewStack.distribution = .fillEqually
        accountInfoViewStack.axis = .vertical
        accountInfoViewStack.translatesAutoresizingMaskIntoConstraints = false
        accountInfoView.addSubview(accountInfoViewStack)

        NSLayoutConstraint.activate([
            accountInfoViewStack.leadingAnchor.constraint(equalTo: accountInfoView.leadingAnchor, constant: 75),
            accountInfoViewStack.topAnchor.constraint(equalTo: accountInfoView.topAnchor, constant: 5),
            accountInfoViewStack.trailingAnchor.constraint(equalTo: accountInfoView.trailingAnchor, constant: -25),
            accountInfoViewStack.bottomAnchor.constraint(equalTo: accountInfoView.bottomAnchor, constant: -5),
        ])
    }

    func updateAccountDetails(account: Account?) {
        if let accountData = account {
            accountAccessLbl.text = accountData.accountName
            accountNumber.text = accountData.accountNumber
            availableFundsValue.text = ""
            availableBalanceValue.text = ""
        }
    }
}
