//
//  ViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 02/01/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var getStartedButton: UIButton!
    
    @IBOutlet var LogInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUiElemenets()
    }


}


extension WelcomeViewController {
    
    func setUpUiElemenets()  {
        
        // Get started button
        getStartedButton.setCornerRadius()
        
        
        // Set up log in button
        LogInButton.setCornerRadius()
        LogInButton.backgroundColor = .white
        LogInButton.layer.borderWidth = 2
        LogInButton.layer.borderColor =  UIColor.appColor(.mainColor)?.cgColor
        
        
        
    }
    
    
    
}

