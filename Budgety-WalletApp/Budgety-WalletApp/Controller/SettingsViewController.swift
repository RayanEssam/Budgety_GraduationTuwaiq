//
//  SettingsViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 13/01/2022.
//

import UIKit

class SettingsViewController: UIViewController {


    @IBOutlet var signoutButton: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var emailLabel: UILabel!
    
    @IBOutlet var modeSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        nameLabel.text = User.shared.userName
        emailLabel.text = User.shared.userEmail
        
    }
    
    
    
    @IBAction func modeSwitchChanged(_ sender: Any) {
    }
    
    
    @IBAction func signuotAction(_ sender: Any) {
    }
    
  
    

}
