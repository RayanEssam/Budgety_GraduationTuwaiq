//
//  UnApprovedSharedWalletViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 11/01/2022.
//

import UIKit

class UnApprovedSharedWalletViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var unapprovedArray : [SharedWallet]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = .clear
        
        if unapprovedArray == nil {
            
//            tableView.isHidden = true
        }

    }
    

    override func viewWillAppear(_ animated: Bool) {
        print("Hellos")
        
        User.shared.unApprovedSharedSavingWallet?.removeAll()
        unapprovedArray?.removeAll()
        
        DatabaseHandler.shared.getUnApprovedSahredWallet { error in
            if error == nil {
               print("Here \(User.shared.unApprovedSharedSavingWallet)")
                self.unapprovedArray = User.shared.unApprovedSharedSavingWallet ?? []
                self.tableView.reloadData()
            }
        }
        
        
        
        
    }
    
    
    

}

extension UnApprovedSharedWalletViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return unapprovedArray?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApproveSavingWalletTableViewCell") as! ApproveSavingWalletTableViewCell
        
        cell.savingWalletAmountLabel.text = "\(unapprovedArray![indexPath.row].target)"
        cell.savingWalletEmailLabel.text = unapprovedArray![indexPath.row].from
        cell.savingWalletNameLabel.text = unapprovedArray![indexPath.row].walletName
        cell.unApprovedWallet = unapprovedArray![indexPath.row]
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
