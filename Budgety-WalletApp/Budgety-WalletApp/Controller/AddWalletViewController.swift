//
//  AddWalletViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 09/01/2022.
//

import UIKit

class AddWalletViewController: UIViewController {

    @IBOutlet var addWalletView: UIView!
    @IBOutlet var soloWalletButton: UIButton!
    @IBOutlet var sharedWalletButton: UIButton!
    @IBOutlet var walletNameTextField: UITextField!
    @IBOutlet var walletTargetTextField: UITextField!
    @IBOutlet var sharedEmailWallet: UITextView!
    @IBOutlet var addWalletButton: UIButton!
    @IBOutlet var sharedEmailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soloWalletButton.setCornerRadius()
        sharedWalletButton.setCornerRadius()
        addWalletView.setCornerRadius()
        addWalletButton.setCornerRadius()
    }
    
    @IBAction func soloActionButton(_ sender: Any) {
        soloWalletButton.backgroundColor =  UIColor.appColor(.mainColor)
        soloWalletButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        sharedWalletButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        sharedWalletButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        sharedEmailLabel.isHidden = true
        sharedEmailWallet.isHidden = true

    }
    
    @IBAction func sharedActionButton(_ sender: Any) {
        sharedWalletButton.backgroundColor =  UIColor.appColor(.mainColor)
        sharedWalletButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        soloWalletButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        soloWalletButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        sharedEmailLabel.isHidden = false
        sharedEmailWallet.isHidden = false
    }
    
    
    @IBAction func addWalletButton(_ sender: Any) {
        
        DatabaseHandler.shared.addNewSoloWallet(soloWallet: SavingWallet(name: "New Car", targetAmount: 120000, currentAmount: 0, type: "Solo", usersEmail: [])) { error in
            
            
            if error == nil {
                print("Done here!")

            }
            
        }
        
        
        
    }
  

}
