//
//  StatesticsTableViewCell.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 13/01/2022.
//

import UIKit

class StatesticsTableViewCell: UITableViewCell {

    @IBOutlet var tipTextContent: UITextView!
    @IBOutlet var innerCard: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
   
        innerCard.setCornerRadius()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
