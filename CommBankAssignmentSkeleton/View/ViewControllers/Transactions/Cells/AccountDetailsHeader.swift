//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import UIKit

class CBATransactionTableHeader: UITableViewHeaderFooterView {
    
    func updateAccountDetails(account: AccountViewModel) {
        accountAccessLbl.text = account.accountName
        accountNumber.text = account.accountNumber
        availableFundsValue.text = account.availableFunds
        availableBalanceValue.text = account.availableBalance
    }
    
    func prepareAmountText(amount: Double) -> String {
        var amt = String(format: "%.2f", amount)
        var amountStr = "$\(amt)"
        if amount < 0 {
            amt = amt.replacingOccurrences(of: "-", with: "")
            amountStr = "-$\(amt)"
        }
        return amountStr
    }
    
    let accountView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    let accountInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    let walletImg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "accountsimagetransactional")
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 5
        return imgView
    }()

    let accountAccessLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = Font.helveticaNeue_light18
        return lbl
    }()

    let accountNumber: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(hexFromString: "878787")
        lbl.font = Font.helveticaNeue_light16
        return lbl
    }()

    let availableFunds: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.StringConstant.available_funds
        lbl.textColor = UIColor(hexFromString: "878787")
        lbl.font = Font.helveticaNeue_light16
        lbl.textAlignment = .left
        return lbl
    }()

    let availableBalance: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.StringConstant.available_balance
        lbl.textColor = UIColor(hexFromString: "878787")
        lbl.font = Font.helveticaNeue_light16
        lbl.textAlignment = .left
        return lbl
    }()

    let availableFundsValue: UILabel = {
        let lbl = UILabel()
        lbl.font = Font.helveticaNeue_Bold16
        lbl.textAlignment = .right
        return lbl
    }()

    let availableBalanceValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hexFromString: "878787")
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
        let placeholderStackView = UIStackView(arrangedSubviews: [accountView, accountInfoView])
        placeholderStackView.distribution = .fillProportionally
        placeholderStackView.axis = .vertical
        placeholderStackView.translatesAutoresizingMaskIntoConstraints = false
        //placeholderStackView.heightAnchor.constraint(equalToConstant:120).isActive = true
        contentView.addSubview(placeholderStackView)
        contentView.layer.borderColor = UIColor(hexFromString: "8AB1B2").cgColor
        contentView.layer.borderWidth = 15.0
        NSLayoutConstraint.activate([
            placeholderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            placeholderStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            placeholderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            placeholderStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])

        let accountStack = UIStackView(arrangedSubviews: [accountAccessLbl, accountNumber])
        accountStack.distribution = .fillProportionally
        accountStack.axis = .vertical
        accountStack.translatesAutoresizingMaskIntoConstraints = false
        walletImg.widthAnchor.constraint(equalToConstant:50).isActive = true
        walletImg.heightAnchor.constraint(equalToConstant:50).isActive = true

        let accountIconStack = UIStackView(arrangedSubviews: [walletImg, accountStack])
        accountIconStack.distribution = .fill
        accountIconStack.axis = .horizontal
        accountIconStack.spacing = 15
        accountIconStack.translatesAutoresizingMaskIntoConstraints = false
        accountIconStack.backgroundColor = .white
        
        accountIconStack.heightAnchor.constraint(equalToConstant:80).isActive = true
        accountView.addSubview(accountIconStack)
        accountView.backgroundColor = .white
        accountView.heightAnchor.constraint(equalToConstant:80).isActive = true
        
        NSLayoutConstraint.activate([
            accountIconStack.leadingAnchor.constraint(equalTo: accountView.leadingAnchor, constant: 30),
            accountIconStack.trailingAnchor.constraint(equalTo: accountView.trailingAnchor, constant: -15),
            accountIconStack.topAnchor.constraint(equalTo: accountView.topAnchor, constant: 15),
            accountIconStack.bottomAnchor.constraint(equalTo: accountView.bottomAnchor, constant: 0)
        ])

        let availableFundStack = UIStackView(arrangedSubviews: [availableFunds, availableFundsValue])
        availableFundStack.distribution = .fillProportionally
        availableFundStack.axis = .horizontal

        let availableBalanceStack = UIStackView(arrangedSubviews: [availableBalance, availableBalanceValue])
        availableBalanceStack.distribution = .fillProportionally
        availableBalanceStack.alignment = .top
        availableBalanceStack.axis = .horizontal

        let accountInfoViewStack = UIStackView(arrangedSubviews: [availableFundStack, availableBalanceStack])
        accountInfoViewStack.distribution = .fillEqually
        accountInfoViewStack.axis = .vertical
        accountInfoViewStack.translatesAutoresizingMaskIntoConstraints = false
        accountInfoViewStack.heightAnchor.constraint(equalToConstant:80).isActive = true
        accountInfoView.addSubview(accountInfoViewStack)

        NSLayoutConstraint.activate([
            accountInfoViewStack.leadingAnchor.constraint(equalTo: accountInfoView.leadingAnchor, constant: 95),
            accountInfoViewStack.topAnchor.constraint(equalTo: accountInfoView.topAnchor, constant: 0),
            accountInfoViewStack.trailingAnchor.constraint(equalTo: accountInfoView.trailingAnchor, constant: -40),
            accountInfoViewStack.bottomAnchor.constraint(equalTo: accountInfoView.bottomAnchor, constant: 0),
        ])
        accountInfoView.heightAnchor.constraint(equalToConstant:80).isActive = true
    }
}
