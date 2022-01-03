//
//  TabBarController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: AddTransactionViewController())

        vc1.title = "Home"
        vc2.title = "Add"
    
        
        self.setViewControllers([vc1,vc2], animated: true)


            
            guard let items = self.tabBar.items else {return}
            
            let images = ["house","plus"]
            
            for i in 0..<items.count {
                items[i].image = UIImage(systemName: images[i])
            }
            
            self.tabBar.backgroundColor = .white
            self.tabBar.tintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            self.modalPresentationStyle = .fullScreen
        
    }

}
