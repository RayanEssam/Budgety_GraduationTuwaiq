//
//  TapBar.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import UIKit

class TapBar: UITabBarController,  UITabBarControllerDelegate {

    @IBOutlet var tapBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

//          if viewController is AddTransactionViewController {
//              print("add tab")
//            
//            let add =   storyboard?.instantiateViewController(withIdentifier: "AddTransactionViewController") as! AddTransactionViewController
//
//
//              self.present(add, animated: true, completion: nil)
//
//          }
      }

}
