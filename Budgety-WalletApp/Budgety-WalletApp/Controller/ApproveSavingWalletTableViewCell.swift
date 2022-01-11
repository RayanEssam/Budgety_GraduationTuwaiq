//
//  ApproveSavingWalletTableViewCell.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 11/01/2022.
//

import UIKit

class ApproveSavingWalletTableViewCell: UITableViewCell {

    @IBOutlet var innerCard: UIView!
    @IBOutlet var savingWalletNameLabel: UILabel!
    
    @IBOutlet var savingWalletAmountLabel: UILabel!
    
    @IBOutlet var savingWalletEmailLabel: UILabel!
    
    @IBOutlet var savingWalletApproveButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func approve(_ sender: Any) {
        
        
        print("Hello from approve")
        
    }
}
