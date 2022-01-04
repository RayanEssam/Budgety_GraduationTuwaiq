//
//  TransactionTableViewCell.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet var transactionLabel: UILabel!
    
    @IBOutlet var transactionDate: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    @IBOutlet var transactionTypeImage: UIImageView!
    
    @IBOutlet var transactionInnerCard: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()

        transactionInnerCard.layer.cornerRadius = 15
    }
  
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
