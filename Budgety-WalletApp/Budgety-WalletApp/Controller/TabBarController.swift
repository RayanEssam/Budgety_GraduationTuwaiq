//
//  TabBarController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import UIKit

class TabBarController: UITabBarController {

    
    override func viewDidLoad() {
        
        print(User.shared.userEmail , " : Tap Bar ")
        
        
        print("Hello Index : " , self.selectedIndex)
        
    }

}
