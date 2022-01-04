//
//  SavingViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 04/01/2022.
//

import UIKit

class SavingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var savingNavigationController: UINavigationBar!
    @IBOutlet var mainSavingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        savingNavigationController.shadowImage = UIImage()
        savingNavigationController.backIndicatorImage = UIImage()
    }
    


}


extension SavingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavingTableViewCell") as!
        SavingTableViewCell
        
        return cell 
        
        
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 500
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 90
//    }
    
    
    
}
