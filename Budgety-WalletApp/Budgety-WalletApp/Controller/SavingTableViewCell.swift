//
//  SavingTableViewCell.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 04/01/2022.
//

import UIKit

class SavingTableViewCell: UITableViewCell {

    @IBOutlet var savingTitle: UILabel!
    @IBOutlet var currentAmount: UILabel!
    @IBOutlet var targetSavingAmount: UILabel!
    @IBOutlet var savingMainView: UIView!
    
    @IBOutlet var walletSlider: UISlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        walletSlider.isEnabled = false
        savingMainView.setCornerRadius()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
