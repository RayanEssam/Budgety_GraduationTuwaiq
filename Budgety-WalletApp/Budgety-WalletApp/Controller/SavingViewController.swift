//
//  SavingViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 04/01/2022.
//

import UIKit

class SavingViewController: UIViewController {
    
    @IBOutlet var addTrasactionFABButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var savingNavigationController: UINavigationBar!
    @IBOutlet var mainSavingView: UIView!
    var savingWallet : [SavingWallet] = []
    let queue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()

        addTrasactionFABButton.layer.cornerRadius = addTrasactionFABButton.frame.width/2
        savingNavigationController.shadowImage = UIImage()
        savingNavigationController.backIndicatorImage = UIImage()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        savingWallet.removeAll()
        User.shared.userSavingWallet?.removeAll()
        
        queue.waitUntilAllOperationsAreFinished()

        
        

       
//        print("in saving vc : " ,User.shared.userSavingWallet)

       
        queue.addOperation {
            DatabaseHandler.shared.getSharedWallet { error in


                self.savingWallet = User.shared.userSavingWallet ?? []

                self.tableView.reloadData()

                print("Gloabal : " , User.shared.userSavingWallet!)

            }
        }
        
        
        queue.addOperation {
            DatabaseHandler.shared.getAllSavingWallet(){ error in


                if error  == nil {


                    self.savingWallet = User.shared.userSavingWallet ?? []
                    self.tableView.reloadData()

                    print("Gloabal : " , User.shared.userSavingWallet!)

                }



            }
        }
        
        
    }
    


}


extension SavingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savingWallet.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavingTableViewCell") as!
        SavingTableViewCell
        cell.currentAmount.text = "\(savingWallet[indexPath.row].currentAmount)"
        cell.targetSavingAmount.text = "\(savingWallet[indexPath.row].targetAmount)"
        cell.walletSlider.minimumValue = 0.0
        cell.walletSlider.maximumValue = savingWallet[indexPath.row].targetAmount
        cell.walletSlider.value = savingWallet[indexPath.row].currentAmount
        cell.savingTitle.text = savingWallet[indexPath.row].name
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
